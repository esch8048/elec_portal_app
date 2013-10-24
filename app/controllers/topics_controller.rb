class TopicsController < ApplicationController
  impressionist :actions=>[:show,:index]
  before_filter :admin_required, :only => :destroy
  def index
    @topics = Topic.all
  end
 
  def show
    @topic = Topic.find(params[:id])
    impressionist(@topic)
  end
 
  def new
    @topic = Topic.new
  end
 
  def create
    @forum = Forum.find(params[:topic][:forum_id])
    @topic = Topic.create(:name => params[:topic][:name], :last_poster_id => current_user.id, :forum_id => @forum.id, :user_id => current_user.id)
     
    if @topic.save
        redirect_to "/forums/#{@topic.forum_id}"
    else
      render :action => 'new'
    end
end
 
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to "/forums/#{@topic.forum_id}"
  end
end