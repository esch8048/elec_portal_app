class UsersController < ApplicationController

  before_filter :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  before_filter :login_required, only: [:new, :create]
  
  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])

  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @rss_feed = @user.build_rss_feed
	@rss_item_1 = @rss_feed.rss_items.build
	@rss_item_2 = @rss_feed.rss_items.build
	@rss_item_3 = @rss_feed.rss_items.build
	
	
	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
	@user[:points] = 0
	@user.save
	@rss_feed = @user.create_rss_feed(:max_items => 10)
	@rss_item_1 = @rss_feed.rss_items.create(:url => "Enter feed url here")
	@rss_item_2 = @rss_feed.rss_items.create(:url => "Enter feed url here")
	@rss_item_3 = @rss_feed.rss_items.create(:url => "Enter feed url here")

    respond_to do |format|
        format.html { redirect_to signin_path, notice: 'Account was successfully created.' }
        format.json { render json: @student, status: :created, location: @student }
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to settings_path, notice: 'Settings were successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
   def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end 
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
