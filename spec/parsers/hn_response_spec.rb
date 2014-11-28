require 'spec_helper'

describe HighSnHn::HnResponse do

  describe "parsing a comment" do

    it "should parse the proper attributes" do
      comment = HighSnHn::HnResponse.new(COMMENT_JSON)
      attribs = {
        hn_id:      COMMENT_JSON['id'],
        body:       COMMENT_JSON['text'],
        parent:     COMMENT_JSON['parent'],
        author:     COMMENT_JSON['by'],
        created_at: Time.at(COMMENT_JSON['time'])
      }
      expect(comment.attributes).to eq(attribs)
    end

    it "should handle a malformed Time" do
      comment = HighSnHn::HnResponse.new({'time' => ''})
      expect { comment.created_at }.to_not raise_error
    end

    it "should return a DateTime when time is malformed" do
      comment = HighSnHn::HnResponse.new({'time' => ''})
      expect(comment.created_at.class.name).to eq('DateTime')
    end

    it "should return the proper class" do
      comment = HighSnHn::HnResponse.new({'type' => COMMENT_JSON['type']})
      expect(comment.klass).to eq(HighSnHn::Comment)
    end
  end # describe "parsing a comment" do

  describe "parsing a story" do

    it "should parse the proper attributes" do
      story = HighSnHn::HnResponse.new(STORY_JSON)
      attribs = {
        hn_id:      STORY_JSON['id'],
        author:     STORY_JSON['by'],
        title:      STORY_JSON['title'],
        url:        STORY_JSON['url'],
        created_at: Time.at(STORY_JSON['time'])
      }
      expect(story.attributes).to eq(attribs)
    end

    it "should parse the proper score" do
      story = HighSnHn::HnResponse.new(STORY_JSON)
      expect(story.score).to eq(STORY_JSON['score'])
    end

    it "should produce a correct URL for a self post" do
      story = HighSnHn::HnResponse.new({
        'id'  => '1234',
        'url' => ''
      })
      expect(story.url).to eq('https://news.ycombinator.com/item?id=1234')
    end

    it "should return 0 for a blank score" do
      story = HighSnHn::HnResponse.new({'score' => ''})
      expect(story.score).to eq(0)
    end

    it "should return the proper class" do
      story = HighSnHn::HnResponse.new({'type' => STORY_JSON['type']})
      expect(story.klass).to eq(HighSnHn::Story)
    end
  end # describe "parsing a story" do
end