require "bundler"
Bundler.setup

desc "Setup the database."
task :db_setup do
  require "./app"
  HighSnHn::Setup.db
end

desc "Get the HN homepage"
task :process_homepage do
  require "./app"
  HighSnHn::HnPage.new.process
end

desc "Tweet out items"
task :tweet_items do
  require "./app"
  point_thresh = 125
  sn_thresh = 2.0
  tweeted = 0
  HighSnHn::Submission.where(tweeted: false)
    .where(:created_at => (Time.now - 2.days)..Time.now)
    .to_a
    .each do |postable|
      if (postable.score > point_thresh) && (postable.score / postable.comment_count.to_f > sn_thresh ) && tweeted < 2
        # don't tweet too many at once
        tweeted += 1
        #HighSnHn::TweetSubmission.new(postable).post
        postable.tweeted = true
        postable.save
      end
    end
end

desc 'Run both the process and the tweet steps'
task :cron => [:process_homepage, :tweet_items]