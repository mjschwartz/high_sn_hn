require 'spec_helper'

describe HighSnHn::Story do
  it "should be setup" do
    expect(HighSnHn::Story.new).to be_an_instance_of(HighSnHn::Story)
  end

  describe 'postable' do
    before(:each) do
      HighSnHn::Story.delete_all
      HighSnHn::Posting.delete_all
      HighSnHn::Snapshot.delete_all
    end

    it 'should not select stories which have postings' do
      story1 = create(:story)
      posting1 = create(:posting, {story: story1})
      story2 = create(:story)
      postable = HighSnHn::Story.postable.select { |x| x.id }

      puts HighSnHn::Story.all.map {|x| x.attributes }
      puts create(:postable).attributes


      expect(postable).to eq([story1.id])
    end
  end

end