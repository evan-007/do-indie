require "spec_helper"

feature "Viewing events" do
	before do
		@event = create(:event)
	end
	scenario "public users can view events" do
		visit root_path
		click_link "Events"
		click_link @event.name
		expect(page).to have_content(@event.name)
	end
end