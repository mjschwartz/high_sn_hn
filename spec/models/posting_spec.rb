require 'spec_helper'

describe HighSnHn::Posting do
  it "should be setup" do
    expect(HighSnHn::Posting.new).to be_an_instance_of(HighSnHn::Posting)
  end

end