module HighSnHn
  class Setup

    def self.db
      ActiveRecord::Base.connection.instance_eval do

        puts "Creating snapshots table..."
        create_table "snapshots", :force => true do |t|
          t.integer   "story_id"
          t.integer   "score"
          t.integer   "comment_count", :default => 0
          t.datetime  "created_at"
          t.datetime  "updated_at"
        end

        add_index "snapshots", ["story_id"], :name => "index_snapshots_on_hn_story_id"

        puts "Creating postings table..."
        create_table "postings", :force => true do |t|
          t.integer   "story_id"
          t.string    "shortened_url"
          t.string    "shortened_comments_url"
          t.datetime  "created_at"
          t.datetime  "updated_at"
        end

        add_index "postings", ["story_id"], :name => "index_postings_on_hn_story_id"

        puts "Creating stories table..."
        create_table "stories", :force => true do |t|
          t.integer   "hn_id"
          t.string    "author"
          t.string    "title"
          t.string    "url", :limit => 1000
          t.datetime  "created_at"
          t.datetime  "updated_at"
        end

        add_index "stories", ["hn_id"], :name => "index_stories_on_hn_id"

        puts "Creating comments table..."
        create_table "comments", :force => true do |t|
          t.integer   "story_id"
          t.integer   "parent"
          t.integer   "hn_id"
          t.string    "author"
          t.datetime  "created_at"
          t.datetime  "updated_at"
        end

        add_index "comments", ["story_id"], :name => "index_comments_on_story_id"

        ActiveRecord::Base.connection.execute("SET collation_connection = 'utf8_general_ci';")
        ActiveRecord::Base.connection.execute("ALTER DATABASE #{ActiveRecord::Base.connection_config[:database]} CHARACTER SET utf8 COLLATE utf8_general_ci;")
        ActiveRecord::Base.connection.execute("ALTER TABLE snapshots CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;")
        ActiveRecord::Base.connection.execute("ALTER TABLE postings CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;")
        ActiveRecord::Base.connection.execute("ALTER TABLE comments CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;")
        ActiveRecord::Base.connection.execute("ALTER TABLE stories CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;")
        puts "done."
      end
    end

    def self.test_db
      if ActiveRecord::Base.connection.table_exists? "snapshots"
        ActiveRecord::Base.connection.drop_table "snapshots"
      end
      if ActiveRecord::Base.connection.table_exists? "postings"
        ActiveRecord::Base.connection.drop_table "postings"
      end
      if ActiveRecord::Base.connection.table_exists? "stories"
        ActiveRecord::Base.connection.drop_table "stories"
      end
      if ActiveRecord::Base.connection.table_exists? "comments"
        ActiveRecord::Base.connection.drop_table "comments"
      end

      self.db
    end
  end
end
