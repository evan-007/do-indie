require "spec_helper"

feature "Liking bands" do
	before do
		@user = create(:user)
		@band = create(:band)
		sign_in @user
	end

	scenario "users can like bands" do
		visit band_en_path(@band)
		click_link 'Like'
		expect(page).to have_content("You are a")
	end

	scenario "user can unlike bands" do
		visit band_en_path(@band)
		click_link 'Like'
		visit band_en_path(@band)
		click_link 'Unlike'
		expect(page).to have_content("You are no longer")
	end
end