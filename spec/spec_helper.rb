require "bundler"
Bundler.setup
require "fakeweb"

ENV["HIGHSNHN_ENV"] = "test"
require_relative "../app"
require_relative './factories'

FakeWeb.allow_net_connect = false
top = File.read(File.join(__dir__, 'support/top.json'))
FakeWeb.register_uri(:get, 'https://hacker-news.firebaseio.com/v0/topstories.json',
  body: top,
  content_type: 'application/json; charset=utf-8')

COMMENT_JSON = JSON.parse(File.read(File.join(__dir__, 'support/comment.json')))
STORY_JSON = JSON.parse(File.read(File.join(__dir__, 'support/story.json')))



HighSnHn::Setup.test_db

RSpec.configure do |config|
#   config.before(:all) do
#     # Create fixtures
#   end
  config.after(:all) do
    # Destroy fixtures
    HighSnHn::Story.delete_all
    HighSnHn::Comment.delete_all
    HighSnHn::Posting.delete_all
    HighSnHn::Snapshot.delete_all
  end
  config.mock_with :rspec
  config.include FactoryGirl::Syntax::Methods
  config.order = "random"
end
