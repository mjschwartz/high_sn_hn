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
      # handle YC job postings
      return nil if @meta_line.css('span').blank?
      @meta_line.css('span').first.text.gsub(' points', '')
    end

    def meta_links
      @meta_line.css('a')
    end

    def hn_id
      # handle YC job postings
      if meta_links.blank?
        if @title_line.xpath('a/@href').text
          @title_line.xpath('a/@href').text.gsub('item?id=', '')
        else
          nil
        end
      else
        meta_links.last.xpath('@href').text.gsub('item?id=', '')
      end
    end

    def user
      # handle YC job postings
      return nil if meta_links.blank?
      meta_links.first.text
    end

    def comment_count
      # handle YC job postings
      return nil if meta_links.blank?
      comment_section = meta_links.last.text
      if comment_section == 'discuss'
        '0'
      else
        comment_section.gsub(' comments', '')
      end
    end

  end

end