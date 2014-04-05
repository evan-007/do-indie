require "spec_helper"

feature "Admin slide panel" do
	before do
		@admin = create(:admin_user)
		sign_in @admin
	end

	scenario "admin users can create slides" do
		visit admin_root_en_path
		click_link "Slides"
		click_link "New Slide"
		fill_in "slide[ko_title]", with: "ganada"
		fill_in "slide[en_title]", with: "abc"
		fill_in "slide[ko_description]", with: "annyoung"
		fill_in "slide[en_description]", with: "delicious"
		fill_in "slide[anchor]", with: "click here"
		fill_in "slide[link]", with: "http://nytimes.com"
		check 'slide[active]'
		click_button "Create Slide"
		expect(page).to have_content('Slide created')
	end

	scenario "admin users can deactivate slides" do
		@slide = create(:slide, active: true)
		visit admin_slides_en_path
		click_link @slide.en_title
		check 'slide[active]'
		click_button "Update Slide"
		expect(page).to have_content('Slide updated')
	end
end