require "spec_helper" 

feature "Venue Manager" do
	before do
		@user = create(:user)
    @venue = create(:venue)
		sign_in @user
	end

	scenario "Users can request edit access" do
    visit venue_en_path(@venue)
		click_link "Request manager status"
		expect(page).to have_content("Thanks, admin will check and approve your request shortly.")
	end

  scenario "Approved users can edit the venue" do 
    @manager = create(:venue_manager, user_id: @user.id, venue_id: @venue.id)
		@manager.update(approved: true)
    visit venue_en_path(@venue)
		expect(page).to have_content("You're a manager")
	end

	scenario "Unapproved users cannot edit" do
    @manager = create(:venue_manager, user_id: @user.id, venue_id: @venue.id)
    visit venue_en_path(@venue)
    expect(page).to_not have_content("Edit this venue")
	end

  scenario "Managers can view managed venues on their homepage" do
    @manager = create(:venue_manager, user_id: @user.id, venue_id: @venue.id)
		@manager.update(approved: true)
		visit inside_en_path
    expect(page).to have_content(@venue.name)
	end
end