module HighSnHn

  class HnResponse

    def initialize(data)
      @data = data
    end

    def hn_id
      @data['id']
    end

    def author
      @data['by']
    end

    def title
      @data['title']
    end

    def score
      @data['score'].blank? ? 0 : @data['score']
    end

    def url
      @data['url'].blank? ? "https://news.ycombinator.com/item?id=#{hn_id}" : @data['url']
    end

    def body
      @data['text']
    end

    def parent
      @data['parent']
    end

    def created_at
      begin
        Time.at(@data['time'])
      rescue TypeError
        DateTime.now
      end
    end

    def story_attributes
      {
        hn_id:      hn_id,
        author:     author,
        title:      title,
        url:        url,
        created_at: created_at
      }
    end

    def comment_attributes
      {
        hn_id:      hn_id,
        body:       body,
        parent:     parent,
        author:     author,
        created_at: created_at
      }
    end
  end
end