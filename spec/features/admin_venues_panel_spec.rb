require "spec_helper"

feature "Admin band panel" do
	before do
		@admin = create(:admin_user)
		@venue = create(:venue)
		sign_in @admin
	end

	scenario "admin users can view venues" do
		visit admin_venues_en_path
		expect(page).to have_content(@venue.name)
	end

	scenario "admin users can edit venues" do
		visit admin_venues_en_path
		click_link @venue.name
		fill_in "venue[name]", with: "psy psy"
		fill_in "venue[phone]", with: "123-123-123"
		fill_in "venue[address]", with: "123 fake street"
		fill_in "venue[en_bio]", with: "best venue ever"
		fill_in "venue[facebook]", with: "facebook.com/psy"
		fill_in "venue[cafe]", with: "naver.com/psy"
		fill_in "venue[website]", with: "psy.com"
		click_button "Update Venue"
		expect(page).to have_content("updated")
	end

	scenario "admins can approve venues" do
		@venue2 = create(:unapproved_venue)
		visit admin_venues_en_path
		click_link @venue2.name.capitalize
	    check "venue[approved]"
		click_button "Update Venue"
		expect(page).to have_content("updated")
	end

	scenario "admins can delete venues" do
		visit admin_venues_en_path
		click_link @venue.name
		click_link "Delete"
		expect(page).to have_content("Venue Deleted")
	end
end