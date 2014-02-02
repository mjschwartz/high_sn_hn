module HighSnHn

  class HnItem

    def initialize(elements)
      @title_line = elements[:title_line]
      @meta_line  = elements[:meta_line]
    end

    def title
      @title_line.css('a').text
    end

    def link
      link = @title_line.xpath('a/@href').text
      if link.match(/^http:/) || link.match(/^https:/)
        link
      else
        "https://news.ycombinator.com/#{link}"
      end
    end

    def score
      @meta_line.css('span').first.text.gsub(' points', '')
    end

    def hn_id
      @meta_line.css('a').last.xpath('@href').text.gsub('item?id=', '')
    end

    def user
      @meta_line.css('a').first.text
    end

    def comment_count
      comment_section = @meta_line.css('a').last.text
      if comment_section == 'discuss'
        '0'
      else
        comment_section.gsub(' comments', '')
      end
    end

  end

end