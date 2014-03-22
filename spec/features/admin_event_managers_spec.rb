require "spec_helper"

feature "Admin event managers" do
	before do
	@user = create(:user)
	@user2 = create(:blogger)
	@event = create(:event)
	@manager = create(:event_manager, user_id: @user.id, event_id: @event.id)
	@admin = create(:admin_user)
	sign_in @admin
	end

  scenario "admins can view all event managers" do
		visit admin_root_en_path
    click_link ("Event Managers")
		expect(page).to have_content(@user.username.capitalize)
	end

	scenario "admins can approve users" do
		visit admin_root_en_path
	    click_link("Event Managers")
		click_link(@user.username.capitalize)
	    select ("yes"), from: "event_manager[approved]"
		click_button ("Update manager")
		expect(page).to have_content("Updated permissions")
	end

	scenario "User gets email when approved?"

	scenario "admin can create event managers using usernames" do
		visit admin_root_en_path
		click_link("Event Managers")
		click_link("New event manager")
		fill_in ("query"), with: @user2.username
		click_button "Search"
		check("event_manager[user_id]")
		select(@event.name, from: "event_manager[event_id]")
		click_button ("Create Event manager")
		expect(page).to have_content("created manager")
	end
end