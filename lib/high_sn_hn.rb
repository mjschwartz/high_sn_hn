# encoding: UTF-8
require_relative "./high_sn_hn/setup"
require_relative "./high_sn_hn/parsers/hn_page"
require_relative "./high_sn_hn/parsers/hn_abstract_item"
require_relative "./high_sn_hn/parsers/hn_item"
require_relative "./high_sn_hn/parsers/hn_ask_item"
require_relative "./high_sn_hn/parsers/hn_job_item"
require_relative "./high_sn_hn/models/posting"
require_relative "./high_sn_hn/models/submission"
require_relative "./high_sn_hn/models/snapshot"
require_relative "./high_sn_hn/services/generate_shortlink"
require_relative "./high_sn_hn/services/process_submissions"
require_relative "./high_sn_hn/services/tweet_submission"

module HighSnHn

  class Keys
    def self.twitter
      keys = YAML.load_file(File.join(__dir__, '../config/app_secret.yml'))
      keys["twitter"]
    end

    def self.google
      keys = YAML.load_file(File.join(__dir__, '../config/app_secret.yml'))
      keys["google"]
    end
  end

end