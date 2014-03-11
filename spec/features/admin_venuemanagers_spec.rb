require "spec_helper"

feature "Admin venue managers" do
	before do
	@user = create(:user)
	@venue = create(:venue)
	@manager = create(:venue_manager, user_id: @user.id, venue_id: @venue.id)
	@admin = create(:admin_user)
	sign_in @admin
	end

	scenario "admins can view all venue managers" do
		visit admin_root_en_path
		click_link ("Venue Managers")
		expect(page).to have_content(@user.username.capitalize)
	end

	scenario "admins can approve users" do
		visit admin_root_en_path
		click_link("Venue Managers")
		click_link(@user.username.capitalize)
		select ("yes"), from: "venue_manager[approved]"
		click_button ("Update manager")
		expect(page).to have_content("Updated permissions")
	end

	scenario "User gets email when approved?"
end