require "spec_helper"

feature "Venue cities" do
	before do
		@city = create(:city)
		@venue = create(:venue, city: @city)
	end

	scenario "public users can view venues by city" do
		visit venues_en_path
		click_link @city.en_name
		expect(page).to have_content (@venue.name)
	end
end