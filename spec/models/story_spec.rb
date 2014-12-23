require 'spec_helper'

describe HighSnHn::Story do

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

    it 'should select stories that are not dead' do
      create(:postable_story, created_at: 3.days.ago)
      postable = HighSnHn::Story.postable.to_a
      expect(postable.map { |x| x.id }).to eq([@story1.id])
    end


    it 'should select stories with snapshots, proper s/n and no postings' do
      create(:posting, story: @story1)
      postable = HighSnHn::Story.postable.to_a
      expect(postable.map { |x| x.id }).to eq([])
    end
  end

  # describe 'update' do

  #   before(:each) do
  #     #allow(HighSnHn::Snapshot).to receive(:hmset).and_return(true)
  #   end

  #   it 'should'



  # end

end