module HighSnHn

  class Snapshot < ActiveRecord::Base
    belongs_to :submission

  end

end