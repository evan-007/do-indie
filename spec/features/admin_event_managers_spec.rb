require "spec_helper"

feature "Admin event managers" do
	before do
	@user = create(:user)
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
end