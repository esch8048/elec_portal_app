class RssItem < ActiveRecord::Base
  belongs_to :rss_feed
  attr_accessible :rss_feed_id, :url
end
