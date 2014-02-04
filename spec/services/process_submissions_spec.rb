require 'spec_helper'

describe HighSnHn::ProcessSubmissions do
  before(:each) do
  end

  describe "submissions are eligible" do
    it "when they they have s_to_n over 2 and 145+ votes" do
      sub = double()
      sub.stub(:score) { 146 }
      sub.stub(:s_to_n) { 2.8 }
      expect(HighSnHn::ProcessSubmissions.new.eligible?(sub)).to be(true)
    end

    it "but not if they have less than 145 votes" do
      sub = double()
      sub.stub(:score) { 46 }
      sub.stub(:s_to_n) { 2.8 }
      expect(HighSnHn::ProcessSubmissions.new.eligible?(sub)).to be(false)
    end

    it "but not when the s_to_ is below 2" do
      sub = double()
      sub.stub(:score) { 146 }
      sub.stub(:s_to_n) { 1.8 }
      expect(HighSnHn::ProcessSubmissions.new.eligible?(sub)).to be(false)
    end
  end

  describe "candiate submissions" do
    before(:each) do
      HighSnHn::Submission.delete_all
      HighSnHn::Posting.delete_all
      HighSnHn::Snapshot.delete_all
    end

    it "should be ordered by s/n descending " do
      sub1 = create(:submission)
      snapshot = create(:snapshot, comment_count: 100, score: 250, submission: sub1)
      sub2 = create(:submission)
      snapshot = create(:snapshot, comment_count: 100, score: 450, submission: sub2)

      expect(HighSnHn::ProcessSubmissions.new.candidates.length).to be(2)
      expect(HighSnHn::ProcessSubmissions.new.candidates.first.id).to be(sub2.id)
    end

    it "should return at most two submissions " do
      sub1 = create(:submission)
      snapshot = create(:snapshot, comment_count: 100, score: 250, submission: sub1)
      sub2 = create(:submission)
      snapshot = create(:snapshot, comment_count: 100, score: 450, submission: sub2)
      sub3 = create(:submission)
      snapshot = create(:snapshot, comment_count: 100, score: 550, submission: sub3)

      expect(HighSnHn::ProcessSubmissions.new.candidates.length).to be(2)
      expect(HighSnHn::ProcessSubmissions.new.candidates.first.id).to be(sub3.id)
    end
  end
end