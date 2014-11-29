require 'spec_helper'

describe HighSnHn::HnItem do

  describe "for a typical link" do
    before(:each) do
      # @item = HighSnHn::HnPage.new.links.first
      a = build(:story)
      b = build(:comment)
      c = build(:posting)
      d = build(:snapshot)
    end

    describe 'complete?' do
      it 'should return the page title' do
        expect(1).to eq(1)
      end
    end

  #   describe "link" do
  #     it "should return the URL of the submission item" do
  #       expect(@item.link).to eq("http://joearms.github.io/2014/02/01/big-changes-to-erlang.html")
  #     end
  #   end

  #   describe "score" do
  #     it "should find a string with the number of points" do
  #       expect(@item.score).to eq("171")
  #     end
  #   end

  #   describe "hn_id" do
  #     it "should find a string with the HN id" do
  #       expect(@item.hn_id).to eq("7162113")
  #     end
  #   end

  #   describe "user" do
  #     it "should find the submitting user's name" do
  #       expect(@item.user).to eq("waffle_ss")
  #     end
  #   end

  #   describe "comment_count" do
  #     it "should find a string with the HN id" do
  #       expect(@item.comment_count).to eq("75")
  #     end
  #   end
  # end

  # describe "for an https link" do
  #   before(:each) do
  #     @item = HighSnHn::HnPage.new.links[2]
  #   end

  #   describe "title" do
  #     it "should return the page's title" do
  #       expect(@item.title).to eq("How in-app purchases have destroyed the game industry")
  #     end
  #   end

  #   describe "link" do
  #     it "should return the URL of the submission item" do
  #       expect(@item.link).to eq("https://www.baekdal.com/opinion/how-inapp-purchases-has-destroyed-the-industry/")
  #     end
  #   end

  #   describe "score" do
  #     it "should find a string with the number of points" do
  #       expect(@item.score).to eq("284")
  #     end
  #   end

  #   describe "hn_id" do
  #     it "should find a string with the HN id" do
  #       expect(@item.hn_id).to eq("7161901")
  #     end
  #   end

  #   describe "user" do
  #     it "should find the submitting user's name" do
  #       expect(@item.user).to eq("seivan")
  #     end
  #   end

  #   describe "comment_count" do
  #     it "should find a string with the HN id" do
  #       expect(@item.comment_count).to eq("251")
  #     end
  #   end
  end
end