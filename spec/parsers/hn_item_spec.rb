require 'spec_helper'

describe HighSnHn::HnItem do

  it 'should find an existing comment' do
    comment = create(:comment, {hn_id: 12345})
    expect(HighSnHn::HnItem.new(12345).model).to eq(comment)
  end

  it 'should set the proper .data when it finds a comment' do
    comment = create(:comment, {hn_id: 12345})
    expect(HighSnHn::HnItem.new(12345).data.except!(:created_at)).to eq(comment.data_attributes.except!(:created_at))
  end

  it 'should find an existing story' do
    story = create(:story, {hn_id: 54321})
    expect(HighSnHn::HnItem.new(54321).model).to eq(story)
  end

  it 'should set the proper .data when it finds a story' do
    story = create(:story, {hn_id: 54321})
    expect(HighSnHn::HnItem.new(54321).data.except!(:created_at)).to eq(story.data_attributes.except!(:created_at))
  end

  it 'should not have a model if there is not one in the DB' do
    expect(HighSnHn::HnItem.new(987654).model).to eq(nil)
  end

  it 'should set data to nil when model not found' do
    expect(HighSnHn::HnItem.new(987654).data).to eq(nil)
  end


  describe 'should_fetch?' do

    it 'should fetch if it did not find a model' do
      expect(HighSnHn::Story).to receive(:where).and_return([])
      expect(HighSnHn::Comment).to receive(:where).and_return([])
      expect(HighSnHn::HnItem.new(54321).should_fetch?).to eq(true)
    end

    it 'should fetch if the model is found but incomplete' do
      story = create(:story, {hn_id: 54321, dead: false})
      expect(HighSnHn::Story).to receive(:where).and_return([story])
      expect(story).to receive(:complete?).and_return(false)

      expect(HighSnHn::HnItem.new(54321).should_fetch?).to eq(true)
    end

    it 'should not fetch if the item is marked dead' do
      story = create(:story, {hn_id: 54321, dead: true})
      expect(HighSnHn::HnItem.new(54321).should_fetch?).to eq(false)
    end

    it 'should not fetch if the item is complete' do
      story = create(:story, {hn_id: 54321})
      expect(HighSnHn::Story).to receive(:where).and_return([story])
      expect(story).to receive(:complete?).and_return(true)

      expect(HighSnHn::HnItem.new(54321).should_fetch?).to eq(false)
    end

  end
end