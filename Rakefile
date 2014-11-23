require 'bundler'
Bundler.setup
require 'resque/tasks'

desc 'Setup the database.'
task :db_setup do
  require './app'
  HighSnHn::Setup.db
end

desc 'Get the HN homepage'
task :process_homepage do
  require './app'
  HighSnHn::HnPage.new.process
end

desc 'Tweet out items'
task :tweet_items do
  require './app'
  HighSnHn::ProcessSubmissions.new.post
end

desc 'Run both the process and the tweet steps'
task :cron => [:process_homepage, :tweet_items]


desc 'Find the current high id'
task :find_high_id do
  require './app'
  Resque.enqueue(HighSnHn::HighIdWorker)
end

desc 'Load envt for Resque'
task 'resque:setup' do
  require './app'
end