class RssFeed < ActiveRecord::Base
  belongs_to :student
  has_many :rss_items, dependent: :destroy
  attr_accessible :max_items, :rss_items, :student_id
end
