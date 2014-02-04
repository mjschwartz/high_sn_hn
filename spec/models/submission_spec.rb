require 'spec_helper'

describe HighSnHn::Submission do

  it "should be included by app.rb" do
    expect(HighSnHn::Submission.new).to be_an_instance_of(HighSnHn::Submission)
  end

  describe "score" do
    it "should be its newest snapshot's score" do
      submission = create(:submission)
      snapshot = create(:snapshot, score: 100, submission: submission, created_at: Time.now - 1.day)
      snapshot = create(:snapshot, score: 200, submission: submission, created_at: Time.now - 1.hour)

      expect(submission.score).to be(200)
    end
  end

  describe "comment count" do
    it "should be its newest snapshot's score" do
      submission = create(:submission)
      snapshot = create(:snapshot, comment_count: 100, submission: submission, created_at: Time.now - 1.day)
      snapshot = create(:snapshot, comment_count: 200, submission: submission, created_at: Time.now - 1.hour)

      expect(submission.comment_count).to be(200)
    end
  end

  describe "s to n" do
    it "should be formed from the newest snapshot's score" do
      submission = create(:submission)
      snapshot = create(:snapshot, comment_count: 100, score: 100, submission: submission, created_at: Time.now - 1.day)
      snapshot = create(:snapshot, comment_count: 200, score: 100, submission: submission, created_at: Time.now - 1.hour)

      expect(submission.s_to_n).to be(0.5)
    end
  end

  describe "postable" do
    it "should include posts made in the last 2 days that haven't been tweeted" do
      submission = create(:submission, tweeted: false, created_at: Time.now - 1.day)

      expect(HighSnHn::Submission.postable.to_a).to include(submission)
    end

    it "should exclude posts made older than 2 days" do
      submission = create(:submission, tweeted: false, created_at: Time.now - 3.day)

      expect(HighSnHn::Submission.postable.to_a).to_not include(submission)
    end

    it "should exclude posts that have already been tweeted" do
      submission = create(:submission, tweeted: true, created_at: Time.now - 1.day)

      expect(HighSnHn::Submission.postable.to_a).to_not include(submission)
    end
  end


end