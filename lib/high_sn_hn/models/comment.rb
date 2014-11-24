module HighSnHn

  class Comment < ActiveRecord::Base
    belongs_to :story

    after_save :get_or_share_story_id

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
      # welp, we don't have it - have it fetched.
      LOGGER.info("enqueuing a fetch for parent Comment#{id}")
      Resque.enqueue(HighSnHn::ItemsWorker, parent, parent)
      return nil
    end

    def complete?
      !!author && !!parent
    end

    private

    def get_or_share_story_id
      return unless self.id
      if self.story_id
        spread_story_to_children
      elsif self.parent
        find_story_from_parent
      end
    end

    def find_story_from_parent
      id = parent_story_id
      update_attribute(:story_id, id) unless id.nil?
    end

    def spread_story_to_children
      HighSnHn::Comment.where(story_id: nil)
        .where(parent: self.hn_id)
        .each { |c| c.update_attribute(:story_id, self.story_id) }
    end

  end
end