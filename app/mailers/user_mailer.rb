class UserMailer < ActionMailer::Base
  default from: "somewhere@random.com"
  
  def welcome_email(user)
    @user = user
    unless @user.get_email == false
      mail(to: @user.email, subject: 'Welcome to Doindie!')      
    end
  end

  def band_approved_email(band)
  	@band = band
  	@user = @band.user
    unless @user.get_email == false
    	mail(to: @user.email, subject: '밴드의 프로필이 두인디에 등록되었습니다. You band’s profile is now live on Doindie!
')
    end
  end

  def event_approved_email(event)
    @event = event
    @user = @event.user
    unless @user.get_email == false
      mail(to: @user.email, subject: '당신의 이벤트가 두인디에 등록되었습니다! / You event is now live on Doindie!
')
    end
  end

  def venue_approved_email(venue)
    @venue = venue
    @user = @venue.user
    unless @user.get_email == false
      mail(to: @user.email, subject: '당신의 공연장이 두인디에 등록되었습니다. / Your venue’s profile is now live on Doindie!
')
    end
  end

  def event_manager_approved(event_manager)
  	@event = event_manager.event
  	@user = event_manager.user
    unless @user.get_email == false
    	mail(to: @user.email, subject: "공연 내용을 관리할 수 있게 되었습니다!
 / Event manager status granted! ")
    end
  end

  def band_manager_approved(band_manager)
   	@band = band_manager.band
  	@user = band_manager.user
    unless @user.get_email == false
    	mail(to: @user.email, subject: " 밴드 관리자 권한이 승인됐습니다.
 / Band manager status granted! ")
    end
  end

  def venue_manager_approved(venue_manager)
  	@venue = venue_manager.venue
  	@user = venue_manager.user
    unless @user.get_email == false
    	mail(to: @user.email, subject: "공연장 관리자 권한이 승인되었습니다! / Venue manager status granted!")
    end
  end
end
