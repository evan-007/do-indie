require "spec_helper"

feature "Creating events" do
	before do
		@user = create(:admin_user)
		@band = create(:band)
		@venue = create(:venue)
		sign_in @user
	end

	scenario "Users can create events" do
		visit root_path
		click_link "New event"
		fill_in "Name", with: "Best party ever"
		fill_in "Contact", with: "010 -1234-1234"
		fill_in "Price", with: "1million wons"
		fill_in "Info", with: "Dress to impress, doors open at 9. Gangnam exit 4"
		click_button "Create Event"
		expect(page).to have_content("Event Created!")
	end
end