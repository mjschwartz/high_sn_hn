module HighSnHn

  class ProcessSubmissions

    def initialize
      @point_thresh = 145
      @sn_thresh = 2.0
      @tweet_limit = 2
    end

    def candidates
      HighSnHn::Submission.postable
        .select { |p| eligible?(p) } # meet vote count and s/n
        .sort { |x,y| y.s_to_n <=> x.s_to_n } # favor the higher s/n
        .slice(0, @tweet_limit) # dont' tweet too many at once
    end

    def eligible?(postable)
      (postable.score > @point_thresh) && (postable.s_to_n > @sn_thresh )
    end

    def post
      candidates.each do |postable|
        HighSnHn::TweetSubmission.new(postable).post
        postable.tweeted = true
        postable.save
      end
    end
  end
end