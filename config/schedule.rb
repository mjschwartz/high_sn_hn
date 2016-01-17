# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#

set :output, '/home/deploy/high_sn_hn/log/cron.log'

every '*/5 * * * *' do
  command "cd /home/deploy/high_sn_hn && HIGHSNHN_ENV=production bundle exec rake find_high_id"
end

every '*/15 * * * *' do
  command "cd /home/deploy/high_sn_hn && HIGHSNHN_ENV=production bundle exec rake top_stories"
end

every '*/30 * * * *' do
  command "cd /home/deploy/high_sn_hn && HIGHSNHN_ENV=production bundle exec rake tweet_items"
end

every :hour do
  command "cd /home/deploy/high_sn_hn && HIGHSNHN_ENV=production bundle exec rake monitor_resque"
end


