# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#

set :output, '/home/deploy/high_sn_hn/log/cron.log'

every '*/5 * * * *' do
  rake "find_high_id"
end