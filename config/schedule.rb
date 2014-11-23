# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#

set :output, '/home/deploy/high_sn_hn/log/cron.log'

every '*/5 * * * *' do
  command "/bin/bash -l -c 'cd /home/deploy/high_sn_hn && HIGHSNHN_ENV=production bundle exec rake find_high_id --silent >> /home/deploy/high_sn_hn/log/cron.log 2>&1'"
  #rake "fill_story_ids"
end

every :hour do
  command "/bin/bash -l -c 'cd /home/deploy/high_sn_hn && HIGHSNHN_ENV=production bundle exec rake fill_story_ids --silent >> /home/deploy/high_sn_hn/log/cron.log 2>&1'"
  #rake "fill_story_ids"
end