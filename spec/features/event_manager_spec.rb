require "spec_helper" 

feature "Event Manager" do
	before do
		@user = create(:user)
    @event = create(:event)
		sign_in @user
	end

	scenario "Users can request edit access" do
    visit event_en_path(@event)
		click_link "Request manager status"
		expect(page).to have_content('pending approval')
	end

  scenario "Approved users can edit the event" do 
    @manager = create(:event_manager, user_id: @user.id, event_id: @event.id)
		@manager.update(approved: true)
    visit event_en_path(@event)
		expect(page).to have_content("Edit this")
	end

	scenario "Unapproved users cannot edit" do
    @manager = create(:event_manager, user_id: @user.id, event_id: @event.id)
    visit event_en_path(@event)
    expect(page).to_not have_content("Edit this event")
	end

  scenario "Managers can view managed events on their homepage" do
    @manager = create(:event_manager, user_id: @user.id, event_id: @event.id)
		@manager.update(approved: true)
		visit inside_en_path
    expect(page).to have_content(@event.name)
	end
end