require "spec_helper"

feature "Editing venues" do
	before do
		@user = create(:user)
        @event = create(:event)
		sign_in @user
	end

  scenario "authenticated users can edit events" do
    visit edit_event_en_path(@event)
    fill_in 'event[name]', with: "Huge party!"
    click_button "Update Event"
    expect(page).to have_content("Event updated!")
	end

  scenario "users with edit abilities can delete events" do
    @event_manager = create(:event_manager, user: @user, event: @event, approved: true)
    visit event_en_path(@event)
    click_link "Edit this event"
    click_link "Delete this event"
    expect(page).to have_content("Event deleted")
  end
end