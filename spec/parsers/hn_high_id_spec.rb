require 'spec_helper'

describe HighSnHn::HnItem do

  it 'should retrieve the high id' do
    expect(HighSnHn::HnHighId.new.id).to eq(123)
  end

end