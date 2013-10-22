json.array!(@rss_items) do |rss_item|
  json.extract! rss_item, :url, :rss_feed_id
  json.url rss_item_url(rss_item, format: :json)
end
