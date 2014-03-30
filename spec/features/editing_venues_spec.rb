require "spec_helper"

feature "Editing venues" do
	before do
		@user = create(:user)
		@venue = create(:venue)
		sign_in @user
	end

  scenario "approved users can edit venues" do
    @manager = create(:venue_manager, user: @user, venue: @venue)
		visit edit_venue_en_path(@venue)
		fill_in 'venue[name]', with: "Eden"
		click_button "Update Venue"
		expect(page).to have_content("Venue updated!")
	end
  
  scenario "unapproved users cannot edit venues" do
    visit edit_venue_en_path(@venue)
    expect(page).to have_content("Sorry")
  end
end