# encoding: UTF-8
module HighSnHn

  class HnPage

    include HTTParty
    base_uri 'https://hacker-news.firebaseio.com'
    format :json
    attr_reader :doc

    def initialize
      @top = top_100
    end

    def self.top_100
      get('/v0/topstories.json',
        options: {headers: {'Content-Type' => 'application/json' } })
      .parsed_response
    end

    def process
      HighSnHn::HnPage.top_100[0..24].each do |id|
        page = HighSnHn::HnPage.item(id)


        if HighSnHn::Submission.where(hn_submission_id: link).exists?
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