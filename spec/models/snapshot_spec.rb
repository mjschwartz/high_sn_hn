require 'spec_helper'

describe HighSnHn::Snapshot do
  it "should be setup" do
    expect(HighSnHn::Snapshot.new).to be_an_instance_of(HighSnHn::Snapshot)
  end

end