require "spec_helper"

feature "Event data" do
	before do 
		@admin = create(:admin_user)
		@event = create(:event)
		sign_in @admin
	end

	scenario "Admin users can access event data" do
		visit admin_events_en_path
		click_link "Get raw event data"
		select "2016", from: "end[year]"
		click_button "Search"
		expect(page).to have_content (@event.name)
	end
end