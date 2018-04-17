require 'spec_helper'

describe HighSnHn::TweetSubmission do
  before(:each) do
    @story = create(:story, {title: 'A cool title'})

    @twitter = instance_double("Twitter::REST::Client")
    allow(Twitter::REST::Client).to receive(:new).and_return(@twitter)
  end

  it "should be included by app.rb" do
    expect(HighSnHn::TweetSubmission.new(@story)).to be_an_instance_of(HighSnHn::TweetSubmission)
  end

  describe "post" do
    before(:each) do
      @comments_url = "https://news.ycombinator.com/item?id=#{@story.hn_id}"
    end

    it "should call the twitter API with the correctly formatted string" do
      @twitter.should_receive(:update).with("A cool title: #{@story.url} ( #{@comments_url} )")
      HighSnHn::TweetSubmission.new(@story).post
    end

    it "should create a record of the posting" do
      create_params = {
        story_id: @story.id,
        shortened_url: @story.url,
        shortened_comments_url: @comments_url,
      }
      @twitter.should_receive(:update)
      HighSnHn::Posting.should_receive(:create).with(create_params)
      HighSnHn::TweetSubmission.new(@story).post
    end
  end
end