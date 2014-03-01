require "spec_helper"

feature "Adding bands to events" do
	before do
		@user = create(:admin_user)
		@event = create(:event)
		@band = create(:band)
		sign_in @user
	end

	scenario "users add bands to events" do
		visit event_path(@event)
		select @band.name, from: "band_id"
	    click_button "Add Band"
	    expect(page).to have_content("Band added!")
	end
end