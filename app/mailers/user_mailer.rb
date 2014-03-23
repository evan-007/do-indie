class UserMailer < ActionMailer::Base
  default from: "evan.u.lloyd@gmail.com"

  def band_approved_email(band)
  	@band = band
  	@user = @band.user
  	mail(to: @user.email, subject: 'Your band was approved!')
  end
end
