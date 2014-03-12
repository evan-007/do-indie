require "spec_helper"

feature "Viewing events" do
	before do
		@event = create(:event)
	end
	scenario "public users can view events" do
		visit events_path
		click_link @event.name
		expect(page).to have_content(@event.name)
	end

	scenario "Past events are not shown in the main index" do
		@event.update(date: Date.yesterday)
		visit events_en_path
		expect(page).to_not have_content(@event.name)
	end
end