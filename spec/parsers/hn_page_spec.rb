require 'spec_helper'

describe HighSnHn::HnPage do
  before(:each) do
  end

  describe "open" do
    it "should return a Nokogiri document" do
      expect(HighSnHn::HnPage.new.doc).to be_an_instance_of(Nokogiri::HTML::Document)
    end

    it "should load the HTML page" do
      expect(HighSnHn::HnPage.new.doc.css('title').first.text).to eq("Hacker News")
    end
  end

  describe "link" do
    it "should return an array of HighSnHn::HnAbstractItem" do
      links = HighSnHn::HnPage.new.links
      expect(links).to be_an_instance_of(Array)
      expect(links.first).to be_an_instance_of(HighSnHn::HnAbstractItem)
    end
  end

end