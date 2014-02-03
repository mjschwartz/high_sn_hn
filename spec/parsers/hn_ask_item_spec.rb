require 'spec_helper'

describe HighSnHn::HnAskItem do

  describe "for a typical link" do
    before(:each) do
      @item = HighSnHn::HnPage.new.links[1]
    end

    describe "title" do
      it "should return the page's title" do
        expect(@item.title).to eq("Ask HN: Who is hiring? (February 2014)")
      end
    end

    describe "link" do
      it "should return the URL of the submission item" do
      expect(@item.link).to eq("https://news.ycombinator.com/item?id=7162197")
      end
    end

    describe "score" do
      it "should find a string with the number of points" do
        expect(@item.score).to eq("151")
      end
    end

    describe "hn_id" do
      it "should find a string with the HN id" do
        expect(@item.hn_id).to eq("7162197")
      end
    end

    describe "user" do
      it "should find the submitting user's name" do
        expect(@item.user).to eq("whoishiring")
      end
    end

    describe "comment_count" do
      it "should find a string with the HN id" do
        expect(@item.comment_count).to eq("164")
      end
    end
  end
end