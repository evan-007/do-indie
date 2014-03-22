require "spec_helper"

feature "Admin cities panel" do
	before do
		@admin = create(:admin_user)
		@city = create(:city)
		sign_in @admin
	end

	scenario "Admin users can edit cities in the admin panel" do
		visit admin_root_en_path
		click_link "Cities"
		click_link @city.en_name
		fill_in "city[ko_name]", with: "Incheon"
		click_button "Update City"
		expect(page).to have_content "updated"
	end

	scenario "Admin users can create new cities" do
		visit admin_root_en_path
		click_link "Cities"
		click_link "New City"
		fill_in "city[en_name]", with: "New York"
		fill_in "city[ko_name]", with: "New York-uh"
		click_button "Create City"
		expect(page).to have_content "created"
	end
end