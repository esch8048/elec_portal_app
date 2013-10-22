json.array!(@topics) do |topic|
  json.extract! topic, :name, :last_poster_id, :last_post_at, :forum_id, :user_id
  json.url topic_url(topic, format: :json)
end
