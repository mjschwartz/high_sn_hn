#High(er) Signal to Noise HN

* https://twitter.com/HighSNHN
* http://matthewschwartz.me/high-signal-to-noise-hn/

What: A Twitter bot that tweets HN submissions that are over 100 points and have a high point to comment ratio.

Why: Passively monitor the most important items that come across HN while attempting to weed out some of the more pop-culture-y or flamebait-y submissions.

This is the basic source code for the bot that gathers the stories from HN, persists the data, and tweets out the stories meeting our criteria.

### Configuration

Create your databases(es) and define database information:

    cp config/database.example.yml database.yml

Define your API keys for Google's URL shortner and your Twitter oAuth credentials.

    cp config/app_secret.example.yml app_secret.yml

Setup the DB:

    rake db_setup

### Environments

The app looks for an evnironment variable called HIGHSNHN_ENV to pick a database.  Set that when envoking rake tasks if you don't want to use the default of "development":

    HIGHSNHN_ENV=production rake cron

### Specs

    rspec

### Gathering data

    rake cron