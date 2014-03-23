class UserMailer < ActionMailer::Base
  default from: "evan.u.lloyd@gmail.com"

  def band_approved_email(band)
  	@band = band
  	@user = @band.user
  	mail(to: @user.email, subject: 'Your band was approved!')
  end

  def event_manager_approved(event_manager)
  	@event = event_manager.event
  	@user = event_manager.user
  	mail(to: @user.email, subject: "DoIndie: manager approval")
  end

  def band_manager_approved(band_manager)
  	@band = band_manager.band
  	@user = band_manager.user
  	mail(to: @user.email, subject: "DoIndie: manager approval")
  end
end
