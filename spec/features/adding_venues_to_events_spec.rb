require "spec_helper"

feature "Adding venues to events" do
	before do
		@user = create(:admin_user)
		@event = create(:event)
		@venue = create(:venue)
		sign_in @user
	end

	scenario "users can add venues to events" do
		visit event_path(@event)
		select @venue.name, from: "venue_id"
		click_button "Add Venue"
		expect(page).to have_content("Venue Added!")
	end
end