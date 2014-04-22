require "spec_helper"

feature "Admin band panel" do
	before do
		@admin = create(:admin_user)
		@band = create(:band)
		sign_in @admin
	end

	scenario "admin users can view bands" do
		visit admin_bands_en_path
		expect(page).to have_content(@band.name)
	end

	scenario "admin users can edit bands" do
		visit admin_bands_en_path
		click_link @band.name
		fill_in "band[name]", with: "psy psy"
		fill_in "band[korean_name]", with: "asdf"
		fill_in "band[contact]", with: "psy@psy.com"
		fill_in "band[facebook]", with: "facebook.com/psy"
		fill_in "band[myspace]", with: "myspace.com/psy"
		fill_in "band[bandcamp]", with: "bandcamp.com/pys"
		fill_in "band[twitter]", with: "twitter.com/psy"
		fill_in "band[site]", with: "psy.com"
	    check "band[approved]"
		click_button "Update Band"
		expect(page).to have_content("updated")
	end
end