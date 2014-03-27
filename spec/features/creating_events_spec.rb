require "spec_helper"

feature "Creating events" do
	before do
		@user = create(:admin_user)
		@band = create(:band)
		@venue = create(:venue)
	end

	scenario "Users can create events" do
		sign_in @user
		visit new_event_en_path
		fill_in "event[name]", with: "Best party ever"
		fill_in "event[contact]", with: "010 -1234-1234"
		fill_in "event[price]", with: "1million wons"
		fill_in "event[info]", with: "Dress to impress, doors open at 9. Gangnam exit 4"
		select @venue.name, from: "event[venue_id]"
		click_button "Create Event"
		expect(page).to have_content("Event Created!")
	end

	scenario "Users can see events they created on the sign in page" do
		@event = create(:event, user: @user)
		sign_in @user
		expect(page).to have_content(@event.name)
	end

	scenario "Non-authenticated users can't add events" do
		visit new_event_en_path
		expect(page).to have_content("Please log in")
	end
end