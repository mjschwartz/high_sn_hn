module HighSnHn

  class Comment < ActiveRecord::Base
    belongs_to :story

    after_save :get_or_share_story_id

    def update(data)
      return false if data.blank?
      update_attributes(data.attributes)
    end

    def parent_story_id
      #LOGGER.info("looking for parent id")
      return story_id if story_id
      return nil unless parent
      # look for the story
      s = HighSnHn::Story.where(hn_id: parent).first
      return s.id if s
      # there wasn't a story with that ID - look for a comment
      c = HighSnHn::Comment.where(hn_id: parent).first
        #LOGGER.info("found a parent: \nc.author.blank?: #{c.author.blank?}\nc.parent.blank?: #{c.parent.blank?}\nc: #{c}")
      if !c.blank? && c.author.blank? && c.parent.blank?
        #LOGGER.info("setting up a queue for #{parent}")
        HighSnHn::ReEnqueueItem.new(parent)
      end
      return c.parent_story_id if c
      # welp, we don't have it - have it fetched.
      # LOGGER.info("enqueuing a fetch for parent Comment#{id}")
      Resque.enqueue(HighSnHn::ItemsWorker, parent, parent)
      return nil
    end

    def complete?
      !!author && !!parent
    end

    def data_attributes
      {
        type:       'comment',
        hn_id:      hn_id,
        body:       body,
        parent:     parent,
        author:     author,
        created_at: created_at
      }
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