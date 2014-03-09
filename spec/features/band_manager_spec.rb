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

	scenario "Approved users can edit the band"

	scenario "Unapproved users cannot edit"
end