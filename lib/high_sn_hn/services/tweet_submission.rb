module HighSnHn

  class TweetSubmission

    def initialize(submission)
      @submission = submission
      api_info = HighSnHn::Keys.twitter
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key = api_info["consumer_key"]
        config.consumer_secret = api_info["consumer_secret"]
        config.access_token = api_info["access_token"]
        config.access_token_secret = api_info["access_token_secret"]
      end
    end

    def post
      #post it
      article_link = HighSnHn::GenerateShortlink.new(@submission.link).shorten
      sleep(3)
      
      comments_url = "http://news.ycombinator.com/item?id=#{@submission.hn_submission_id}"
      comments_link = HighSnHn::GenerateShortlink.new(comments_url).shorten
      sleep(3)

      twitter_text = @submission.title + ": " + article_link + " ( " + comments_link + " )"
      #@client.update(twitter_text)
      sleep(3)
    end

  end

end