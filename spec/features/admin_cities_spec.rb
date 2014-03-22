require "spec_helper"

feature "Editing cities" do
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
		click_button "Update city"
		expect(page).to have_content "updated"
	end
end