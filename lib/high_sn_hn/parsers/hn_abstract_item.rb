module HighSnHn

  class HnAbstractItem

    attr_reader :page

    def initialize(elements)
      link = elements[:title_line].xpath('a/@href')

      if elements[:meta_line].css('a').blank?
        # this is a YC Job posting
        @page = HighSnHn::HnJobItem.new({
          title_line: elements[:title_line],
          meta_line: elements[:meta_line]
        })
      elsif link.text && !link.text.match(/^https?:/)
        # this is a Ask HN style self post
        @page = HighSnHn::HnAskItem.new({
          title_line: elements[:title_line],
          meta_line: elements[:meta_line]
        })
      else
        # this is a normal posting to an external URL
        @page = HighSnHn::HnItem.new({
          title_line: elements[:title_line],
          meta_line: elements[:meta_line]
        })
      end
    end

    def title
      @page.title
    end

    def link
      @page.link
    end

    def score
      @page.score
    end

    def hn_id
      @page.hn_id
    end

    def user
      @page.user
    end

    def comment_count
      @page.comment_count
    end

  end

end