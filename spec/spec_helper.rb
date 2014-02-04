require "bundler"
Bundler.setup

require "fakeweb"
FakeWeb.allow_net_connect = false
html = File.read(File.join(__dir__, 'support/test.html'))
FakeWeb.register_uri(:get, "https://news.ycombinator.com/", :body => html)

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
