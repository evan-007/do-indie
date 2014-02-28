require "spec_helper"

feature "Editing venues" do
	before do
		@user = create(:user)
		@venue = create(:venue)
		sign_in @user
	end

	scenario "authenticated users can edit venues" do
		visit edit_venue_path(@venue)
		fill_in 'Name', with: "Eden"
		click_button "Update Venue"
		expect(page).to have_content("Venue updated!")
	end
end