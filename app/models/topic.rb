class Topic < ActiveRecord::Base
  attr_accessible :name, :last_poster_id, :last_post_at, :forum_id, :user_id
  validates_presence_of :name
  belongs_to :forum
  belongs_to :user
  has_many :posts, :dependent => :destroy
   
  def most_recent_post_username  
    username = User.first().name
    return username 
  end
end