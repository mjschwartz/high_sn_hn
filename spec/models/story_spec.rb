require 'spec_helper'

describe HighSnHn::Story do
  it "should be setup" do
    expect(HighSnHn::Story.new).to be_an_instance_of(HighSnHn::Story)
  end

end