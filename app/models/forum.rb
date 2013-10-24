class Forum < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :topics, :dependent => :destroy
  validates_presence_of :name
  validates_presence_of :description
   
  def most_recent_post  
    topic = Topic.first(:order => 'last_post_at DESC', :conditions => ['forum_id = ?', self.id])  
    return topic  
  end
end