require 'feed-normalizer'
class RssItemsController < ApplicationController
  # GET /rss_items
  # GET /rss_items.json
  def index
    @rss_items = RssItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rss_items }
    end
  end

  # GET /rss_items/1
  # GET /rss_items/1.json
  def show
    @rss_item = RssItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rss_item }
    end
  end

  # GET /rss_items/new
  # GET /rss_items/new.json
  def new
    @rss_item = RssItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rss_item }
    end
  end

  # GET /rss_items/1/edit
  def edit
    @rss_item = RssItem.find(params[:id])
  end

  # POST /rss_items
  # POST /rss_items.json
  def create
    @rss_item = RssItem.new(params[:rss_item])

    respond_to do |format|
      if @rss_item.save
        format.html { redirect_to @rss_item, notice: 'Rss feed was successfully created.' }
        format.json { render json: @rss_item, status: :created, location: @rss_item }
      else
        format.html { render action: "new" }
        format.json { render json: @rss_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rss_items/1
  # PUT /rss_items/1.json
  def update
    @rss_item = RssItem.find(params[:id])
    @url_test = params[:rss_item][:url]
	begin
		begin
			parsed_feed = FeedNormalizer::FeedNormalizer.parse open(@url_test.strip)
			if parsed_feed.nil?
				redirect_to customise_feed_path, notice: 'Invalid feed!'
			else	
				@rss_item.update_attributes(params[:rss_item])
				redirect_to feed_path, notice: 'Rss feed was successfully updated.'	  
			end
		rescue
			redirect_to customise_feed_path, notice: 'Invalid feed!'
		end
	end
	

	#respond_to do |format|
	#	  if v.valid?
	#		@rss_item.update_attributes(params[:rss_item])
	#		format.html { redirect_to portal_home_path, notice: 'Rss feed was successfully updated.' }
	#		format.json { head :no_content }
	#	  else
	#		format.html { redirect_to customise_feed_path, notice: 'Invalid feed!' }
	#		format.json { render json: @rss_item.errors, status: :unprocessable_entity }
	#	  end
    #end
  end

  # DELETE /rss_items/1
  # DELETE /rss_items/1.json
  def destroy
    @rss_item = RssItem.find(params[:id])
    @rss_item.destroy

    respond_to do |format|
      format.html { redirect_to rss_items_url }
      format.json { head :no_content }
    end
  end
end
