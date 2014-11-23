require "bundler"
Bundler.setup

require "fakeweb"
FakeWeb.allow_net_connect = false
top = File.read(File.join(__dir__, 'support/top.json'))
FakeWeb.register_uri(:get, 'https://hacker-news.firebaseio.com/v0/topstories.json',
  body: top,
  content_type: 'application/json; charset=utf-8')


ENV["HIGHSNHN_ENV"] = "test"

require_relative "../app"
require_relative './factories'

HighSnHn::Setup.test_db

RSpec.configure do |config|
#   config.before(:all) do
#     # Create fixtures
#   end
  config.after(:all) do
    # Destroy fixtures
    HighSnHn::Submission.delete_all
    HighSnHn::Posting.delete_all
    HighSnHn::Snapshot.delete_all
  end
  config.mock_with :rspec
  config.include FactoryGirl::Syntax::Methods
  config.order = "random"
end
