require 'spec_helper'

describe HighSnHn::Page do
  before(:each) do
  end

  describe "open" do
    it "should return a Nokogiri document" do
      expect(HighSnHn::Page.new.doc).to be_an_instance_of(Nokogiri::HTML::Document)
    end

    it "should load the HTML page" do
      expect(HighSnHn::Page.new.doc.css('title').first.text).to eq("Hacker News")
    end
  end

  describe "link" do
    it "should return an array of HighSnHn::HnItem" do
      links = HighSnHn::Page.new.links
      expect(links).to be_an_instance_of(Array)
      expect(links.first).to be_an_instance_of(HighSnHn::HnItem)
    end
  end

end