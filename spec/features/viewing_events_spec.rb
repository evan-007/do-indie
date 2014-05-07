require "spec_helper"

feature "Viewing events" do
	before do
		@event = create(:event)
	end
	scenario "public users can view approved events" do
		visit events_path
		first(:link, @event.name).click
		expect(page).to have_content(@event.name)
	end

	scenario "Past events are not shown in the main index" do
		@event.update(date: Date.yesterday)
		visit events_en_path
		expect(page).to_not have_content(@event.name)
	end

	scenario "public users can't view unapproved events" do
		@event2 = create(:unapproved_event)
		visit events_en_path
		expect(page).to_not have_content(@event2.name)
	end

	scenario "public users can view past events" do
		@event.update(date: Date.yesterday)
		visit past_events_en_path
		expect(page).to have_content @event.name
	end

	context "viewing events by city" do

		scenario "users can view upcoming events" do
			@city = create(:city)
			@event.update(city: @city)
			visit events_en_path
			click_link @city.en_name
			expect(page).to have_content @event.name
		end

		scenario "no city link when no upcoming events" do
			@city = create(:city)
			visit events_en_path
			expect(page).to_not have_content @city.en_name
		end

		scenario "city#event shows error when no upcoming events" do
			@city = create(:city)
			visit city_event_en_path(@city.en_name)
			expect(page).to have_content("Sorry, no")
		end
	end
end