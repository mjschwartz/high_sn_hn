require 'spec_helper'

describe HighSnHn::ReEnqueueItem do

  before(:each) do
    @redis = instance_double('Redis')
    allow(@redis).to receive(:hmset).and_return(true)
    allow(@redis).to receive(:hmget).and_return(['1'])
    stub_const('REDIS', @redis)

    allow(Resque).to receive(:enqueue)

    @id = 12345
  end

  it 'should be included by app.rb' do
    expect(HighSnHn::ReEnqueueItem.new(@id)).to be_an_instance_of(HighSnHn::ReEnqueueItem)
  end

  it 'should look in the Redis hash "failed_get" for a key matching the item id' do
    expect(@redis).to receive(:hmget).with('failed_get', @id).and_return(['1'])

    HighSnHn::ReEnqueueItem.new(@id)
  end

  it 'should set the failed count to 1 when it does not exist as a key' do
    expect(@redis).to receive(:hmget).with('failed_get', @id).and_return(nil)
    expect(@redis).to receive(:hmset).with('failed_get', @id, 1)

    HighSnHn::ReEnqueueItem.new(@id)
  end

  it 'should increment the failed count when it does exist as a key' do
    expect(@redis).to receive(:hmget).with('failed_get', @id).and_return(['2'])
    expect(@redis).to receive(:hmset).with('failed_get', @id, 3)

    HighSnHn::ReEnqueueItem.new(@id)
  end

  it 'should not set a new count when it has already been called 5 times' do
    expect(@redis).to receive(:hmget).with('failed_get', @id).and_return(['5'])
    expect(@redis).not_to receive(:hmset)

    HighSnHn::ReEnqueueItem.new(@id)
  end

  it 'should not re-enqueue when it has already been called 5 times' do
    expect(@redis).to receive(:hmget).with('failed_get', @id).and_return(['5'])
    expect(Resque).not_to receive(:enqueue)

    HighSnHn::ReEnqueueItem.new(@id)
  end

  it 'should re-enqueue when it has been called less than 5 times' do
    expect(@redis).to receive(:hmget).with('failed_get', @id).and_return(['2'])
    expect(Resque).to receive(:enqueue)

    HighSnHn::ReEnqueueItem.new(@id)
  end
end