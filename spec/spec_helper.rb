require "bundler"
Bundler.setup

require 'fakeweb'


html = File.read(File.join(__dir__, 'support/test.html'))
FakeWeb.register_uri(:get, "https://news.ycombinator.com/", :body => html)

ENV["HIGHSNHN_ENV"] = "test"

require_relative "../app"

HighSnHn::Setup.test_db

# RSpec configuration
# RSpec.configure do |config|
#   config.before(:all) do
#     # Create fixtures
#   end
#   config.after(:all) do
#     # Destroy fixtures
#   end
#   config.around(:each) do |example|
#     begin
#       example.run
#     rescue Exception => ex
#       save_and_open_page
#       raise ex
#     end
#   end
# end

RSpec.configure do |config|
  config.mock_with :rspec
  #config.use_transactional_fixtures = true
  #config.fixture_path = "#{Rails.root}/spec/fixtures"
  config.order = "random"
end