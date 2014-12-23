module HighSnHn
  class Setup

    def self.tables
      ["snapshots", "postings", "stories", "comments", "titles"]
    end

    def self.db
      ActiveRecord::Base.connection.instance_eval do

        puts "Creating comments table..."
        create_table "comments", :force => true do |t|
          t.integer   "story_id"
          t.integer   "parent"
          t.integer   "hn_id"
          t.string    "author"
          t.text      "body"
          t.boolean   "dead", default: 0
          t.datetime  "created_at"
          t.datetime  "updated_at"
        end
        add_index "comments", ["story_id"], :name => "index_comments_on_story_id"
        add_index "comments", ["hn_id"], :name => "index_comments_on_hn_id"

        puts "Creating postings table..."
        create_table "postings", :force => true do |t|
          t.integer   "story_id"
          t.string    "shortened_url"
          t.string    "shortened_comments_url"
          t.datetime  "created_at"
          t.datetime  "updated_at"
        end
        add_index "postings", ["story_id"], :name => "index_postings_on_hn_story_id"

        puts "Creating snapshots table..."
        create_table "snapshots", :force => true do |t|
          t.integer   "title_id"
          t.integer   "story_id"
          t.integer   "score", default: 0
          t.integer   "comment_count", default: 0
          t.datetime  "created_at"
        end
        add_index "snapshots", ["story_id"], :name => "index_snapshots_on_hn_story_id"

        puts "Creating stories table..."
        create_table "stories", :force => true do |t|
          t.integer   "hn_id"
          t.string    "author"
          t.string    "title"
          t.boolean   "dead", default: 0
          t.string    "url", limit: 1000
          t.datetime  "created_at"
          t.datetime  "updated_at"
        end
        add_index "stories", ["hn_id"], :name => "index_stories_on_hn_id"

        puts "Creating titles table..."
        create_table "titles", :force => true do |t|
          t.string    "body"
        end

        ActiveRecord::Base.connection.execute("SET collation_connection = 'utf8mb4_unicode_ci';")
        ActiveRecord::Base.connection.execute("ALTER DATABASE #{ActiveRecord::Base.connection_config[:database]} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;")
        self.tables.each do |t|
          sql = "ALTER TABLE #{t} CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
          ActiveRecord::Base.connection.execute(sql)
        end
        puts "done."
      end
    end

    def self.test_db
      self.tables.each do |t|
        if ActiveRecord::Base.connection.table_exists?(t)
          ActiveRecord::Base.connection.drop_table(t)
        end
      end

      self.db
    end
  end
end
