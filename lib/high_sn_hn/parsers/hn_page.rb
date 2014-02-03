module HighSnHn

  class HnPage
    attr_reader :doc

    def initialize
      @doc = fetch_homepage
    end

    def fetch_homepage
      Nokogiri::HTML(open("https://news.ycombinator.com/"))
    end

    def links
      @doc.css("td.subtext").collect do |l|
        HighSnHn::HnAbstractItem.new({
          title_line: l.parent.xpath("preceding-sibling::*[1]").css("td.title").last,
          meta_line: l
        })
      end
    end

    def process
      links.each do |link|
        if HighSnHn::Submission.where(hn_submission_id: link.hn_id).exists?
          sub = HighSnHn::Submission.where(hn_submission_id: link.hn_id).first
        else 
          sub = HighSnHn::Submission.create({
            hn_submission_id: link.hn_id,
            title: link.title,
            link: link.link,
            submitting_user: link.user,
            tweeted: false
          })
        end
        HighSnHn::Snapshot.create({
          score: link.score,
          comment_count: link.comment_count,
          submission_id: sub.id
        })
      end
    end
  end

end