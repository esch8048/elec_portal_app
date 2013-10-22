class CreateRssFeeds < ActiveRecord::Migration
  def change
    create_table :rss_feeds do |t|
      t.integer :max_items
      t.integer :user_id

      t.timestamps
    end
  end
end
