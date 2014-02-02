module HighSnHn

  class Submission < ActiveRecord::Base
    has_many :snapshots

    def score
      return nil if snapshots.blank?

      snapshots.order("created_at DESC").first.score
    end

    def comment_count
      return nil if snapshots.blank?

      snapshots.order("created_at DESC").first.comment_count
    end

  end

end