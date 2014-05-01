require "spec_helper"

feature "Admin event panel" do
	before do
		@admin = create(:admin_user)
		@event = create(:event)
		sign_in @admin
	end

	scenario "admin users can view events" do
		visit admin_events_en_path
		expect(page).to have_content(@event.name)
	end

	scenario "admin users can edit events" do
		visit admin_events_en_path
		first(:link, @event.name).click
		fill_in "event[name]", with: "psy psy"
		fill_in "event[contact]", with: "123-123-123"
		fill_in "event[price]", with: "4 dolla"
		fill_in "event[info]", with: "it's a party for your mom"
		click_button "Update Event"
		expect(page).to have_content("updated")
	end

	scenario "admin users can approve events" do
		@event2 = create(:unapproved_event)
		visit admin_events_en_path
		click_link @event2.name.capitalize
	    check "event[approved]"
		click_button "Update Event"
		expect(page).to have_content("updated")
	end
end