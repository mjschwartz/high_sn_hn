require 'spec_helper'

describe HighSnHn::HnItem do

  describe "for a typical link" do
    before(:each) do
      @item = HighSnHn::Page.new.links.first
    end

    describe "title" do
      it "should return the page's title" do
        expect(@item.title).to eq("Big changes to Erlang")
      end
    end

    describe "link" do
      it "should return the URL of the submission item" do
        expect(@item.link).to eq("http://joearms.github.io/2014/02/01/big-changes-to-erlang.html")
      end
    end

    describe "score" do
      it "should find a string with the number of points" do
        expect(@item.score).to eq("171")
      end
    end

    describe "hn_id" do
      it "should find a string with the HN id" do
        expect(@item.hn_id).to eq("7162113")
      end
    end

    describe "user" do
      it "should find the submitting user's name" do
        expect(@item.user).to eq("waffle_ss")
      end
    end

    describe "comment_count" do
      it "should find a string with the HN id" do
        expect(@item.comment_count).to eq("75")
      end
    end
  end

  describe "for an Ask HN story" do
    it "should create a link to the comments section" do
      @item = HighSnHn::Page.new.links[1]
      expect(@item.link).to eq("https://news.ycombinator.com/item?id=7162197")
    end
  end

  describe "for a story linking to https" do
    it "should should properly form the link" do
      @item = HighSnHn::Page.new.links[2]
      expect(@item.link).to eq("https://www.baekdal.com/opinion/how-inapp-purchases-has-destroyed-the-industry/")
    end
  end


end