module HighSnHn

  class Story < ActiveRecord::Base
    after_save :spread_id_to_children

    has_many :comments
    has_many :snapshots, dependent: :destroy
    has_many :postings, dependent: :destroy

    scope :postable, -> do
      includes(:postings)
        .where(postings: { story_id: nil } )
        .includes(:snapshots)
        .where(dead: false)
        .where.not(snapshots: { id: nil } )
        .where(created_at: (Time.now - 2.days)..Time.now)
    end

    def score
      @_score ||= snapshots.blank? ? 0 : snapshots.order("created_at DESC").first.score
    end

    def comment_count
      @_comment_count ||= snapshots.blank? ? 0 : snapshots.order("created_at DESC").first.comment_count
    end

    def s_to_n
      return 0 if comment_count == 0
      score.to_f / comment_count.to_f
    end

    def update(data)
      return false if data.blank?

      update_attributes(data.attributes)

      HighSnHn::Snapshot.create({
        story_id:      id,
        score:         data.score,
        comment_count: comments.count
      })
    end

    def data_attributes
      {
        type:       'story',
        hn_id:      hn_id,
        author:     author,
        title:      title,
        url:        url,
        created_at: created_at,
        score:      score,
        dead:       dead
      }
    end

    def complete?
      !!author && !!title && !!url
    end

    private

    def spread_id_to_children
      return unless self.id
      HighSnHn::Comment.where(parent: hn_id)
        .where(story_id: nil)
        .each { |c| c.update_attribute(:story_id, self.id) }
    end
  end
end