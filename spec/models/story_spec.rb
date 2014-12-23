require 'spec_helper'

describe HighSnHn::Story do

  before(:each) do
    HighSnHn::Story.delete_all
    HighSnHn::Posting.delete_all
    HighSnHn::Snapshot.delete_all
  end
  it "should be setup" do
    expect(HighSnHn::Story.new).to be_an_instance_of(HighSnHn::Story)
  end

  describe 'postable' do
    before(:each) do
      @story1 = create(:postable_story)
      @story2 = create(:story)
    end
    it 'should select stories with snapshots' do
      postable = HighSnHn::Story.postable.to_a
      expect(postable.map { |x| x.id }).to eq([@story1.id])
    end

    it 'should select stories that are not dead' do
      create(:postable_story, dead: true)
      postable = HighSnHn::Story.postable.to_a
      expect(postable.map { |x| x.id }).to eq([@story1.id])
    end

    it 'should select stories with snapshots, proper s/n and no postings' do
      create(:posting, story: @story1)
      postable = HighSnHn::Story.postable.to_a
      expect(postable.map { |x| x.id }).to eq([])
    end
  end

end