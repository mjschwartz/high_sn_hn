module HighSnHn

  class Submission < ActiveRecord::Base
    has_many :snapshots
    has_many :postings

    scope :postable, -> { where(tweeted: false, created_at: (Time.now - 2.days)..Time.now) }

    def score
      return 0 if snapshots.blank?

      snapshots.order("created_at DESC").first.score || 0
    end

    def comment_count
      return 0 if snapshots.blank?

      snapshots.order("created_at DESC").first.comment_count || 0
    end

    def s_to_n
      score / comment_count.to_f || 0
    end

  end

end