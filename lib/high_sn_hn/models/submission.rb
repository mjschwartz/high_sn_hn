module HighSnHn

  class Submission < ActiveRecord::Base
    has_many :snapshots
    has_many :postings

    def score
      return nil if snapshots.blank?

      snapshots.order("created_at DESC").first.score || 0
    end

    def comment_count
      return nil if snapshots.blank?

      snapshots.order("created_at DESC").first.comment_count || 0
    end

  end

end