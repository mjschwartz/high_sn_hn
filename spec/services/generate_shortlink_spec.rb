require 'spec_helper'
FakeWeb.register_uri(
  :post, %r|https://www.googleapis.com.*|,
  :body => JSON.generate({id: "http://googly.com/foo"}),
  :status => ["200", "OK"]
  )

#https://www.googleapis.com/urlshortener/v1/url

describe HighSnHn::GenerateShortlink do

  it "should be included by app.rb" do
    expect(HighSnHn::GenerateShortlink.new('foo')).to be_an_instance_of(HighSnHn::GenerateShortlink)
  end

  describe "shorten" do
    it "should return the 'id' param of a request to Google's URL shortner" do
      expect(HighSnHn::GenerateShortlink.new('foo').shorten).to eq("http://googly.com/foo")
    end
  end


end