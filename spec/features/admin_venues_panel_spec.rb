require "spec_helper"

feature "Admin band panel" do
	before do
		@admin = create(:admin_user)
		@venue = create(:venue)
		sign_in @admin
	end

	scenario "admin users can view venues" do
		click_link "Admin"
		find("h4", text: "Venues").click_link "Venues"
		expect(page).to have_content(@venue.name)
	end

	scenario "admin users can edit venues" do
		visit admin_venues_path
		click_link @venue.name
		fill_in "Name", with: "psy psy"
		fill_in "Phone", with: "123-123-123"
		fill_in "Address", with: "123 fake street"
		fill_in "Misc", with: "best venue ever"
		fill_in "Facebook", with: "facebook.com/psy"
		fill_in "Cafe", with: "naver.com/psy"
		fill_in "Website", with: "psy.com"
		click_button "Update venue"
		expect(page).to have_content("updated")
	end
end