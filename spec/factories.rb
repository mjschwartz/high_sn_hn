require "factory_girl"


FactoryGirl.define do

  factory :snapshot, class: HighSnHn::Snapshot do
    score 10
    comment_count 100
    created_at (Time.now - 1.day)
    submission
  end

  factory :submission, class: HighSnHn::Submission do
    hn_submission_id 2604013
    title "A cool title"
    link "http//sosmart.tumblr.com/"
    submitting_user "foobar"
    tweeted 0
    created_at (Time.now - 1.hour)
  end

end