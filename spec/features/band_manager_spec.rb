require "spec_helper" 

feature "Band Manager" do
	before do
		@user = create(:user)
		@band = create(:band)
		sign_in @user
	end

	scenario "Users can request edit access" do
		visit band_en_path(@band)
		click_link "Request manager status"
		expect(page).to have_content("Thanks, admin will check and approve your request shortly.")
	end

	scenario "Approved users can edit the band" do 
		@manager = create(:band_manager, user_id: @user.id, band_id: @band.id)
		@manager.update(approved: true)
		visit band_en_path(@band)
		expect(page).to have_content("You're a manager")
	end

	scenario "Unapproved users cannot edit" do
		@manager = create(:band_manager, user_id: @user.id, band_id: @band.id)
		visit band_en_path(@band)
		expect(page).to_not have_content("Edit this band")
	end

	scenario "Managers can view managed bands on their homepage" do
		@manager = create(:band_manager, user_id: @user.id, band_id: @band.id)
		@manager.update(approved: true)
		visit inside_en_path
		expect(page).to have_content(@band.name)
	end
end