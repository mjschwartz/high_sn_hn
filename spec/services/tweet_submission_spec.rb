require 'spec_helper'

describe HighSnHn::TweetSubmission do
  before(:each) do
    @sub = create(:submission)

    @twitter = double()
    Twitter::REST::Client.should_receive(:new).and_return(@twitter)
  end

  it "should be included by app.rb" do
    expect(HighSnHn::TweetSubmission.new(@sub)).to be_an_instance_of(HighSnHn::TweetSubmission)
  end

  describe "post" do
    before(:each) do
      @shortener = double()
      @shortener.stub(:shorten) { "http://googly.com/foo" }
      comments_url = "https://news.ycombinator.com/item?id=#{@sub.hn_submission_id}"
      HighSnHn::GenerateShortlink.should_receive(:new).once.ordered.with(@sub.link).and_return(@shortener)
      HighSnHn::GenerateShortlink.should_receive(:new).once.ordered.with(comments_url).and_return(@shortener)
    end

    it "should call the twitter API with the correctly formatted string" do
      @twitter.should_receive(:update).with("A cool title: http://googly.com/foo ( http://googly.com/foo )")
      HighSnHn::TweetSubmission.new(@sub, true).post
    end

    it "should create a record of the posting" do
      create_params = {
        submission_id: @sub.id,
        shortened_url: "http://googly.com/foo",
        shortened_comments_url: "http://googly.com/foo",
      }
      @twitter.should_receive(:update)
      HighSnHn::Posting.should_receive(:create).with(create_params)
      HighSnHn::TweetSubmission.new(@sub, true).post
    end
  end


end