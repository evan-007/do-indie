require "spec_helper"

feature "Liking bands" do
	before do
		@user = create(:user)
		@band = create(:band)
		sign_in @user
	end

	scenario "users can like bands" do
		visit band_path(@band)
		click_link 'Like'
		expect(page).to have_content("You're a fan!")
	end
end