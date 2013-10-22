class Topic < ActiveRecord::Base
  attr_accessible :name, :last_poster_id, :last_post_at
  belongs_to :forum
  belongs_to :user
  has_many :posts, :dependent => :destroy
   
  def most_recent_post_username  
    username = User.first().username
    return username 
  end
end