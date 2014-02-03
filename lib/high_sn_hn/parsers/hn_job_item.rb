module HighSnHn

  class HnJobItem

    def initialize(elements)
      @title_line = elements[:title_line]
      @meta_line  = elements[:meta_line]
    end

    def title
      @title_line.css('a').text
    end

    def link
      link = @title_line.xpath('a/@href')
      if link.text &&  link.text.match(/^https?:/)
        link.text
      else
        "https://news.ycombinator.com/#{link.text}"
      end
    end

    def score
      nil
    end

    def meta_links
      @meta_line.css('a')
    end

    def hn_id
      @title_line.xpath('a/@href').text.gsub('item?id=', '')
    end

    def user
      nil
    end

    def comment_count
      nil
    end

  end

end