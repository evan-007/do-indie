require "spec_helper"

feature "Creating venues" do
	before do
		@user = create(:admin_user)
		sign_in @user
	end
	scenario "Users can create venues" do
		visit new_venue_en_path
		fill_in "Name", with: "Avalon"
		fill_in "Phone", with: "010-1234-1234"
		fill_in "Address", with: "Gangnam station, exit 2"
		fill_in "venue[en_bio]", with: "Best club in G-nam"
		fill_in "Facebook", with: "facebook.com"
		fill_in "Cafe", with: "naver.com"
		fill_in "Website", with: "gangnamstyle.com"
		click_button "Create Venue"
		expect(page).to have_content("Venue Created!")
	end

	
end