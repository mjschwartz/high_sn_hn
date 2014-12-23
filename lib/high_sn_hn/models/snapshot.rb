module HighSnHn
  class Snapshot < ActiveRecord::Base
    belongs_to :story
    belongs_to :title
  end
end