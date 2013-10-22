require 'feed-normalizer'
require 'open-uri'
require 'nokogiri'
require 'prawn'
#require 'barby'
#require 'barby/barcode/code_128'
#require 'barby/outputter/png_outputter'
require 'FileUtils'
class PortalHomeController < ApplicationController
	include ActionView::Helpers::TextHelper

  def index
  
	@index = true
	if current_user
		feed_items = current_user.rss_feed.rss_items
		@feeds = []
		@max_items = current_user.rss_feed.max_items
		
		for feed_item in feed_items
			if feed_item.url == "Enter feed url here"
			else
				@feeds.push(FeedNormalizer::FeedNormalizer.parse open(feed_item.url.strip))
			end
		end	

		@stories = @feeds.size * @max_items
		
		if @feeds.size == 0
			@no_feeds = true
		end
		
		@points = current_user.points
	else
		redirect_to login_url
    end
  end
  
  def customise 
   @rss_feed = current_user.rss_feed
   @customise = true
   @rss_feed_item_1 = @rss_feed.rss_items.first
   @rss_feed_item_2 = @rss_feed.rss_items.second
   @rss_feed_item_3 = @rss_feed.rss_items.third
   render "index"
  
  
  end
  
  
  def points_whats_this
	@points_whats_this = true
	render "index"
  end
  
  def settings
	@show_settings = true
	@user = current_user
	render "index"
	#@user.update_attributes(params[:user])	
  end
  
  def edit_settings
	@edit_settings = true
	@user = current_user
	render "index"
  end
  
  
  def redeempoints
	@redeempoints = true
	render "index"
  end
  
  def redeem_points
    @points_to_redeem = params[:points_redeemed]
	
	if current_user.points < @points_to_redeem.to_i
		#error, not enough points
		flash.now[:alert] = "You don't have enough points!"
		@redeempoints = true
		render "index"
	else
		@points_string = pluralize(@points_to_redeem, "point")
		
		#generate barcode
		#barcode = Barby::Code128B.new('barcode')
		#File.open('/sample_app/assets/images/barcode.png', 'w'){|f|
		#  f.write Barby::PngOutputter.new(barcode).to_png(:height => 20, :margin => 5)
		#}	
		
		#generate pdf - add some more things to it!	
		Prawn::Document.generate("#{Rails.root}/app/assets/redeempoints.pdf") do |pdf|
			pdf.encrypt_document
			pdf.image "#{Rails.root}/app/assets/images/elecportallogo.png"
			pdf.span(350, :position => :center) do
			 pdf.text "Coupon for #{@points_string}, redeemable at any USYD Camperdown campus store"
			 pdf.text "*Please note that this is for demonstration purposes only and is not a real thing!"
			end
		end


		#send email
		PointsMailer.points_email(current_user).deliver
		
		#delete pdf
		#File.delete("#{Rails.root}/app/assets/redeempoints.pdf")
		
		#deduct points
		old_points = current_user.points
		current_user.update_attributes(:points => old_points - @points_to_redeem.to_i)	
		
		#render next view
		respond_to do |format|
			format.html { redirect_to portal_home_path, notice: 'A coupon has been sent to your email address.' }
		end
	end
	
  end
  
  def forum
	redirect_to forums_url
  end
  
  def blogs
  end

end