require_relative "./high_sn_hn/page"

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