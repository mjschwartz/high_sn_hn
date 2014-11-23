module HighSnHn

  class Story < ActiveRecord::Base
    after_save :spread_id_to_children

    has_many :comments

    def update(data)
      update_attributes({
        hn_id:   data['id'],
        author:  data['by'],
        title:   data['title'],
        url:     url_for(data),
        created_at: Time.at(data['time'])
      })

      HighSnHn::Snapshot.create({story_id: id, score: data['score']})
    end

    def complete?
      !!author && !!title && !!url
    end


    private

    def spread_id_to_children
      HighSnHn::Comment.where(parent: hn_id)
        .where(story_id: nil)
        .update_all(story_id: id)
    end

    def url_for(data)
      data['url'].blank? ? "https://news.ycombinator.com/item?id=#{data['id']}" : data['url']
    end
  end
end