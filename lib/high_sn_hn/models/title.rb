module HighSnHn
  class Title < ActiveRecord::Base
    has_many :snapshots

  end
end