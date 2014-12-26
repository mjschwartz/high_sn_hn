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
  #Resque.enqueue(HighSnHn::HighIdWorker)
  HighSnHn::HighIdWorker.perform
end

desc 'Parse the current Top 100 stories list'
task :top_stories do
  require './app'
  #Resque.enqueue(HighSnHn::TopStoryWorker)
  HighSnHn::TopStoryWorker.perform
end

desc 'Stop the Resque worker'
task :stop_resque do
  require './app'
  pwd = File.dirname(File.expand_path(__FILE__))
  path = "#{pwd}/log/resque.pid"
  f = File.open(path, "rb")
  pid = f.read

  if pid.blank?
    puts "No worker to kill"
  else
    syscmd = "kill -s QUIT #{pid}"
    puts "Running syscmd: #{syscmd}"
    system(syscmd)
    File.open(path, 'w') {|file| file.truncate(0) }
  end

  f.close
end

desc 'Start a Resque worker'
task :start_resque do
  puts "Starting worker"
  pwd = File.dirname(File.expand_path(__FILE__))
  ops = {
    pgroup: true,
    err: [(pwd + "/log/resque_err.log").to_s, "a"],
    out: [(pwd + "/log/resque_stdout.log").to_s, "a"]
  }
  env_vars = {
    'PIDFILE' => pwd + '/log/resque.pid',
    'BACKGROUND' => 'yes',
    'HIGHSNHN_ENV' => 'production',
    'TERM_CHILD' => '1',
    'RESQUE_TERM_TIMEOUT' => '10',
    'QUEUES' => '*'
  }
  pid = spawn(env_vars, "rake resque:work", ops)
  Process.detach(pid)
end

desc 'Load envt for Resque'
task 'resque:setup' do
  require './app'
end