require "spec_helper"

feature "Approval email" do
	before do
		@user = create(:user)
		@band = create(:unapproved_band, user: @user)
		@event = create(:unapproved_event, user: @user)
		@venue = create(:unapproved_venue, user: @user)
	end

	scenario "Users get email after band approval" do
		@band.update(approved: true)
		expect(open_last_email).to be_delivered_to @user.email
	end

	scenario "users get email after event approval" do
		@event.update(approved: true)
		expect(open_last_email).to be_delivered_to @user.email
	end

	scenario "users get email after venue approval" do
		@venue.update(approved: true)
		expect(open_last_email).to be_delivered_to @user.email
	end
  
  scenario "users with get_email:false don't get email" do
    @user2 = create(:admin_user)
    @band2 = create(:unapproved_band, name: 'dif name', user: @user2)
    @user2.update(get_email: false)
    @band2.update(approved: true)
    expect(open_last_email).to_not be_delivered_to @user2.email
  end
end