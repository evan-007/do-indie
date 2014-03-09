require "spec_helper"

feature "Admin band managers" do
	before do
	@user = create(:user)
	@band = create(:band)
	@manager = create(:band_manager, user_id: @user.id, band_id: @band.id)
	@admin = create(:admin_user)
	sign_in @admin
	end

	scenario "admins can view all band managers" do
		visit admin_root_en_path
		click_link ("Band Managers")
		expect(page).to have_content(@user.username.capitalize)
	end
end