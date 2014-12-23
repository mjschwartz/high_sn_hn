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
  end # describe 'postable' do

  describe 'update' do

    before(:each) do
      @story = build(:story)
      @data = HighSnHn::HnResponse.new({
        "by" => "JamesTKirk",
        "id" => 976,
        "score" => 212,
        "time" =>  1.hour.ago.to_i,
        "title" => "Green Ladies Like Kirk",
        "type" => "story",
        "url" => "https://foo.bar"
      })
    end

    it 'should return the model when provided data' do
      expect(@story.update(@data)).to eq(@story)
    end

    it 'should return false when data not provided' do
      expect(@story.update({})).to eq(false)
    end

    it 'should update the attributes of a story' do
      @story.update(@data)

      expect(@story.hn_id).to eq(@data.hn_id)
      expect(@story.author).to eq(@data.author)
      expect(@story.title).to eq(@data.title)
      expect(@story.dead).to eq(@data.dead)
      expect(@story.created_at).to eq(@data.created_at)
    end

    it 'should create a snapshot' do
      snaps = HighSnHn::Snapshot.count
      @story.update(@data)

      expect(HighSnHn::Snapshot.count).to eq(snaps + 1)
    end

    it 'should create a Title if one does not exist' do
      expect(HighSnHn::Title.where(body: @data.title).exists?).to eq(false)
      @story.update(@data)

      expect(HighSnHn::Title.where(body: @data.title).exists?).to eq(true)
    end

    it 'should re-use a Title if one does exist' do
      create(:title, body: @data.title)
      expect(HighSnHn::Title.where(body: @data.title).exists?).to eq(true)
      titles = HighSnHn::Title.count
      @story.update(@data)

      expect(HighSnHn::Title.count).to eq(titles)
    end

  end # describe 'update' do
end