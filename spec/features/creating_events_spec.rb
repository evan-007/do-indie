require "spec_helper"

feature "Creating events" do
	before do
		@user = create(:admin_user)
		@band = create(:band)
		@venue = create(:venue)
		sign_in @user
	end

	scenario "Users can create events" do
		visit new_event_path
		fill_in "event[name]", with: "Best party ever"
		fill_in "event[contact]", with: "010 -1234-1234"
		fill_in "event[price]", with: "1million wons"
		fill_in "event[info]", with: "Dress to impress, doors open at 9. Gangnam exit 4"
		select @venue.name, from: "event[venue_id]"
		click_button "Create Event"
		expect(page).to have_content("Event Created!")
	end
end