module HighSnHn
  class Setup

    def self.db
      ActiveRecord::Base.connection.instance_eval do
        puts "Creating submissions table..."
        create_table "submissions", :force => true do |t|
          t.integer   "hn_submission_id"
          t.string    "title"
          t.string    "link"
          t.string    "submitting_user"
          t.boolean   "tweeted"
          t.datetime  "created_at"
          t.datetime  "updated_at"
        end
        add_index "submissions", ["hn_submission_id"], :name => "index_submissions_on_hn_submission_id"
        
        puts "Creating snapshots table..."
        create_table "snapshots", :force => true do |t|
          t.integer   "submission_id"
          t.integer   "score"
          t.integer   "comment_count"
          t.datetime  "created_at"
          t.datetime  "updated_at"
        end

        add_index "snapshots", ["submission_id"], :name => "index_snapshots_on_hn_submission_id"

        puts "done."
      end
    end

    def self.test_db
      if ActiveRecord::Base.connection.table_exists? "submissions"
        ActiveRecord::Base.connection.drop_table "submissions"
      end
      if ActiveRecord::Base.connection.table_exists? "snapshots"
        ActiveRecord::Base.connection.drop_table "snapshots"
      end

      self.db
    end
  end
end
