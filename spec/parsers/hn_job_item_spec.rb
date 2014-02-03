require 'spec_helper'

describe HighSnHn::HnJobItem do

  describe "for a YC job posting" do
    before(:each) do
      @item = HighSnHn::HnPage.new.links[3]
    end

    it "should should be an instance of " do
      expect(@item.page).to be_an_instance_of(HighSnHn::HnJobItem)
    end

    it "should should properly form the link" do
      expect(@item.link).to eq("https://news.ycombinator.com/item?id=7169004")
    end

    describe "title" do
      it "should return the page's title" do
        expect(@item.title).to eq("Join Firebase as Production Engineer #2")
      end
    end

    describe "score" do
      it "should find a string with the number of points" do
        expect(@item.score).to eq(0)
      end
    end

    describe "hn_id" do
      it "should find a string with the HN id" do
        expect(@item.hn_id).to eq("7169004")
      end
    end

    describe "user" do
      it "should find the submitting user's name" do
        expect(@item.user).to eq(nil)
      end
    end

    describe "comment_count" do
      it "should find a string with the HN id" do
        expect(@item.comment_count).to eq(0)
      end
    end
  end

end