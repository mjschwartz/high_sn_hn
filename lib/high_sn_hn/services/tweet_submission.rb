module HighSnHn

  class TweetSubmission

    def initialize(story, skip_sleep=false)
      @skip_sleep = skip_sleep || false # gross way to make specs less annoying
      @story = story
      api_info = HighSnHn::Keys.twitter
      # @client = Twitter::REST::Client.new do |config|
      #   config.consumer_key = api_info["consumer_key"]
      #   config.consumer_secret = api_info["consumer_secret"]
      #   config.access_token = api_info["access_token"]
      #   config.access_token_secret = api_info["access_token_secret"]
      # end
    end

    def record_posting(short_url, short_comments_url)
      HighSnHn::Posting.create({
        story_id: @story.id,
        shortened_url: short_url,
        shortened_comments_url: short_comments_url,
      })
    end

    # We sleep in between each API call - we aren't in a hurry since we do
    # at most 2 per cron job, so just playing it safe.
    def post
      article_link = HighSnHn::GenerateShortlink.new(@story.url).shorten
      sleep(2) unless @skip_sleep

      comments_url = "https://news.ycombinator.com/item?id=#{@story.hn_id}"
      comments_link = HighSnHn::GenerateShortlink.new(comments_url).shorten
      sleep(2) unless @skip_sleep

      twitter_text = @story.title + ": " + article_link + " ( " + comments_link + " )"
      LOGGER.info("\ntweeting #{@story.id}: #{twitter_text}\n")
      #@client.update(twitter_text)

      record_posting(article_link, comments_link)
    end
  end
end