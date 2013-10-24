class RssItem < ActiveRecord::Base
  belongs_to :rss_feed
  attr_accessible :rss_feed_id, :url
  
  require 'feed_validator'
  def validation(url)
    v = W3C::FeedValidator.new()
	v.validate_url('http://www.w3.org/QA/news.rss')
	puts v.to_s unless v.valid?
  end
end
