require 'spec_helper'

describe HighSnHn::ProcessSubmissions do
  before(:each) do
  end

  describe "submissions are eligible" do
    it "when they they have s_to_n over 2 and 150+ votes" do
      story = double(score: 151, s_to_n: 2.8)
      expect(HighSnHn::ProcessSubmissions.new.eligible?(story)).to be(true)
    end

    it "but not if they have less than 150 votes" do
      story = double(score: 46, s_to_n: 2.8)
      expect(HighSnHn::ProcessSubmissions.new.eligible?(story)).to be(false)
    end

    it "but not when the s_to_n is below 2" do
      story = double(score: 156, s_to_n: 1.8)
      expect(HighSnHn::ProcessSubmissions.new.eligible?(story)).to be(false)
    end
  end

  describe "candiate submissions" do

    it "should be ordered by s/n descending " do
      sub1 = create(:story)
      snapshot = create(:snapshot, comment_count: 100, score: 450, story: sub1, created_at: DateTime.now)
      sub2 = create(:story)
      snapshot = create(:snapshot, comment_count: 100, score: 550, story: sub2, created_at: DateTime.now)

      expect(HighSnHn::ProcessSubmissions.new.candidates.length).to be(2)
      expect(HighSnHn::ProcessSubmissions.new.candidates.first.id).to be(sub2.id)
    end

    it "should return at most two submissions " do
      sub1 = create(:story)
      snapshot = create(:snapshot, comment_count: 100, score: 250, story: sub1, created_at: DateTime.now)
      sub2 = create(:story)
      snapshot = create(:snapshot, comment_count: 100, score: 450, story: sub2, created_at: DateTime.now)
      sub3 = create(:story)
      snapshot = create(:snapshot, comment_count: 100, score: 550, story: sub3, created_at: DateTime.now)

      expect(HighSnHn::ProcessSubmissions.new.candidates.length).to be(2)
      expect(HighSnHn::ProcessSubmissions.new.candidates.first.id).to be(sub3.id)
    end
  end
end