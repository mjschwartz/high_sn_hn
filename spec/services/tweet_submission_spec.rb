require 'spec_helper'

describe HighSnHn::TweetSubmission do
  before(:each) do
    @story = create(:story)

    @twitter = double()
    Twitter::REST::Client.should_receive(:new).and_return(@twitter)
  end

  it "should be included by app.rb" do
    expect(HighSnHn::TweetSubmission.new(@story)).to be_an_instance_of(HighSnHn::TweetSubmission)
  end

  describe "post" do
    before(:each) do
      @shortener = double(shorten: "http://googly.com/foo")
      comments_url = "https://news.ycombinator.com/item?id=#{@story.hn_id}"
      HighSnHn::GenerateShortlink.should_receive(:new).once.ordered.with(@story.url).and_return(@shortener)
      HighSnHn::GenerateShortlink.should_receive(:new).once.ordered.with(comments_url).and_return(@shortener)
    end

    it "should call the twitter API with the correctly formatted string" do
      @twitter.should_receive(:update).with("A cool title: http://googly.com/foo ( http://googly.com/foo )")
      HighSnHn::TweetSubmission.new(@story, true).post
    end

    it "should create a record of the posting" do
      create_params = {
        submission_id: @story.id,
        shortened_url: "http://googly.com/foo",
        shortened_comments_url: "http://googly.com/foo",
      }
      @twitter.should_receive(:update)
      HighSnHn::Posting.should_receive(:create).with(create_params)
      HighSnHn::TweetSubmission.new(@story, true).post
    end
  end


end