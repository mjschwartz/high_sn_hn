require 'bundler'
Bundler.setup
require 'resque/tasks'

desc 'Setup the database.'
task :db_setup do
  require './app'
  HighSnHn::Setup.db
end

desc 'Tweet out items'
task :tweet_items do
  require './app'
  HighSnHn::ProcessSubmissions.new.post
end

desc 'Find the current high id'
task :find_high_id do
  require './app'
  Resque.enqueue(HighSnHn::HighIdWorker)
end

desc 'Parse the current Top 100 stories list'
task :top_stories do
  require './app'
  Resque.enqueue(HighSnHn::TopStoryWorker)
end

desc 'Load envt for Resque'
task 'resque:setup' do
  require './app'
end