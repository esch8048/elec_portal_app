class PointsMailer < ActionMailer::Base
  default from: "elecportalnoreply@gmail.com"
  
  def points_email(user)
    @user = user
	time = Time.now.getutc
	attachments["redeempoints#{time}.pdf"] = File.read("#{Rails.root}/app/assets/redeempoints.pdf", :mode => 'rb')
    mail(to: "#{user.email}", subject: "ELECPortal: Points Coupon")
	
  end  
end
