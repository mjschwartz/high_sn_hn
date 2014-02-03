require 'spec_helper'

describe HighSnHn::HnAbstractItem do
  before(:each) do
  end

  describe "an HN item with a normal style link" do
    it "should build an HighSnHn::HnItem" do
      item = HighSnHn::HnPage.new.links.first
      expect(item.page).to be_an_instance_of(HighSnHn::HnItem)
    end
  end

  describe "a normal HN item with an https link" do
    it "should build an HighSnHn::HnItem" do
      item = HighSnHn::HnPage.new.links[2]
      expect(item.page).to be_an_instance_of(HighSnHn::HnItem)
    end
  end

  describe "an HN item with a Ask HN style link" do
    it "should build an HighSnHn::HnItem" do
      item = HighSnHn::HnPage.new.links[1]
      expect(item.page).to be_an_instance_of(HighSnHn::HnAskItem)
    end
  end

  describe "an item that looks like a YC job posting" do
    it "should build an HighSnHn::HnJobItem" do
      item = HighSnHn::HnPage.new.links[3]
      expect(item.page).to be_an_instance_of(HighSnHn::HnJobItem)
    end
  end
end