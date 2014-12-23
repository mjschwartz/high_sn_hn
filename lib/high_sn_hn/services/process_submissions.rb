module HighSnHn

  class ProcessSubmissions

    def initialize
      @point_thresh = 150
      @sn_thresh    = 2.00
      @tweet_limit  = 2
    end

    def candidates
      HighSnHn::Story.postable
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
      end
    end
  end
end