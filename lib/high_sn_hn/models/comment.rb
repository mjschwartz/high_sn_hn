module HighSnHn

  class Comment < ActiveRecord::Base
    belongs_to :story

    after_save :fill_in_story
    after_save :spread_story_to_children

    def update(data)
      update_attributes({
        hn_id:   data['id'],
        parent:  data['parent'],
        author:  data['by'],
        created_at: Time.at(data['time'])
      })
    end

    def parent_story_id
      return story_id if story_id
      return nil unless parent
      # look for the story
      s = HighSnHn::Story.where(hn_id: parent).first
      return s.id if s
      # there wasn't a story with that ID - look for a comment
      c = HighSnHn::Comment.where(hn_id: parent).first
      return c.parent_story_id if c
      # welp - we have to have it fetched.  Will let the rake task fill it in
      LOGGER.info("enqueuing a fetch for parent Comment#{id}")
      Resque.enqueue(HighSnHn::ItemsWorker, parent, parent)
      return nil
    end

    def complete?
      !!author && !!parent
    end

    private

    def fill_in_story
      return if story_id
      id = parent_story_id
      update_attribute(:story_id, id) unless id.nil?
    end

    def spread_story_to_children
      return unless story_id
      HighSnHn::Comment.where(parent: hn_id)
        .where(story_id: nil)
        .update_all(story_id: story_id)
    end

  end
end