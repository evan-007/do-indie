require "spec_helper"

feature "Admin band managers" do
	before do
	@user = create(:user)
	@user2 = create(:blogger)
	@band = create(:band)
	@manager = create(:band_manager, user_id: @user.id, band_id: @band.id)
	@admin = create(:admin_user)
	sign_in @admin
	end

	scenario "admins can view all band managers" do
		visit admin_root_en_path
		click_link ("Band Managers")
		expect(page).to have_content(@user.username.capitalize)
	end

	scenario "admins can approve users" do
		visit admin_root_en_path
		click_link("Band Managers")
		click_link(@user.username.capitalize)
		select ("yes"), from: "band_manager[approved]"
		click_button ("Update manager")
		expect(page).to have_content("Updated permissions")
	end

	scenario "User gets email when approved?"

	scenario "admin can create band managers using usernames" do
		visit admin_root_en_path
		click_link("Band Managers")
		click_link("New band manager")
		fill_in ("query"), with: @user2.username
		click_button "Search"
		check("band_manager[user_id]")
		select(@band.name, from: "band_manager[band_id]")
		click_button ("Create Band manager")
		expect(page).to have_content("created manager")
	end
end