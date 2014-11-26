require "factory_girl"


FactoryGirl.define do

  factory :stories, class: HighSnHn::Story do
    score 10
    comment_count 100
    created_at (Time.now - 1.day)
    submission
  end

  factory :snapshot, class: HighSnHn::Snapshot do
    score 10
    comment_count 100
    created_at (Time.now - 1.day)
    submission
  end

end