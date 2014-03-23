require "spec_helper"

feature "Admin venue managers" do
	before do
	@user = create(:user)
	@venue = create(:venue)
	@manager = create(:venue_manager, user_id: @user.id, venue_id: @venue.id)
	@admin = create(:admin_user)
	@user2 = create(:blogger)
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

	scenario "User gets email when approved?" do
		@manager.update(approved: true)
		expect(open_last_email).to be_delivered_to @user.email
	end

	scenario "admin can create venue managers using usernames" do
		visit admin_root_en_path
		click_link("Venue Managers")
		click_link("New venue manager")
		fill_in ("query"), with: @user2.username
		click_button "Search"
		check("user_id")
		select(@venue.name, from: "venue_id")
		click_button ("Save changes")
		expect(page).to have_content("created manager")
	end
end