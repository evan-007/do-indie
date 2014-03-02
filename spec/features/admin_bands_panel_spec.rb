require "spec_helper"

feature "Admin band panel" do
	before do
		@admin = create(:admin_user)
		@band = create(:band)
		sign_in @admin
	end

	scenario "admin users can view bands" do
		click_link "Admin"
		find("h4", text: "Bands").click_link "Bands"
		expect(page).to have_content(@band.name)
	end
end