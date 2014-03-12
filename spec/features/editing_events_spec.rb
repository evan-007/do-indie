require "spec_helper"

feature "Editing venues" do
	before do
		@user = create(:user)
    @event = create(:event)
		sign_in @user
	end

  scenario "authenticated users can edit events" do
    visit edit_event_path(@event)
    fill_in 'event[name]', with: "Huge party!"
    click_button "Update Event"
    expect(page).to have_content("Event updated!")
	end
end