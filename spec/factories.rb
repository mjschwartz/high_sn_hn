require "factory_girl"


FactoryGirl.define do

  factory :story, class: HighSnHn::Story do
    hn_id '123456'
    author 'JaneDoe'
    title 'Crazy game of poker'
    url 'http://foo.com/story'
    dead false
    created_at (Time.now - 1.day)
  end

  factory :comment, class: HighSnHn::Comment do
    story
    hn_id  '123457'
    author 'JohnDoe'
    body   'We will fight on the beaches.'
    parent  nil
    dead    false
    created_at (Time.now - 1.day)
  end

  factory :snapshot, class: HighSnHn::Snapshot do
    score 10
    comment_count 100
    created_at (Time.now - 1.day)
    association :story
  end

  factory :posting, class: HighSnHn::Posting do
    shortened_comments_url 'http://goo.gl/a'
    shortened_url 'http://goo.gl/b'
    association :story
  end
end