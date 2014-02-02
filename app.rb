require 'yaml'
require 'active_record'
require 'mysql2'
require 'nokogiri'
require 'open-uri'
require 'twitter'

db_environment = ENV["HIGHSNHN_ENV"] || "development"

db_config = YAML.load_file(File.join(__dir__, 'config/database.yml'))
ActiveRecord::Base.establish_connection(db_config[db_environment])



require "./lib/high_sn_hn"