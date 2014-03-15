require "spec_helper"

feature "Venue cities" do
	before do
		@venue = create(:venue)
		@city = create(:city)
		@venue_city = create(:venue_city, venue_id: @venue.id, city_id: @city.id)
	end

	scenario "public users can view venues by city" do
		visit venues_en_path
		click_link @city.en_name
		expect(page).to have_content (@venue.name)
	end
end