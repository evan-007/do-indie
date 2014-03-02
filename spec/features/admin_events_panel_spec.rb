require "spec_helper"

feature "Admin event panel" do
	before do
		@admin = create(:admin_user)
		@event = create(:event)
		sign_in @admin
	end

	scenario "admin users can view events" do
		click_link "Admin"
		find("h4", text: "Events").click_link "Events"
		expect(page).to have_content(@event.name)
	end

	scenario "admin users can edit events" do
		visit admin_events_path
		click_link @event.name
		fill_in "Name", with: "psy psy"
		fill_in "Contact", with: "123-123-123"
		fill_in "Price", with: "4 dolla"
		fill_in "Info", with: "it's a party for your mom"
		click_button "Update event"
		expect(page).to have_content("updated")
	end
end