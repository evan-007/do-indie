require "spec_helper"

feature "Creating venues" do
	before do
		@user = create(:admin_user)
	end

	scenario "Users can create venues" do
		sign_in @user
		visit new_venue_en_path
		fill_in "venue[name]", with: "Avalon"
		fill_in "venue[phone]", with: "010-1234-1234"
		fill_in "venue[address]", with: "Gangnam station, exit 2"
		fill_in "venue[en_bio]", with: "Best club in G-nam"
		fill_in "venue[facebook]", with: "facebook.com"
		fill_in "venue[cafe]", with: "naver.com"
		fill_in "venue[website]", with: "gangnamstyle.com"
		click_button "Create Venue"
		expect(page).to have_content("Thanks")
	end

	scenario "users can see venues they created on the sign in page" do
		@venue = create(:venue, user: @user)
		sign_in @user
		expect(page).to have_content(@venue.name)
	end

	scenario "Non-authenticated users cannot add venues" do
		visit new_venue_en_path
		expect(page).to have_content("sign in")
	end
end