class CreateRssItems < ActiveRecord::Migration
  def change
    create_table :rss_items do |t|
      t.string :url
      t.integer :rss_feed_id

      t.timestamps
    end
  end
end
