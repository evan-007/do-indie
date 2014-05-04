require "spec_helper"

feature "Slides" do
	context "bloggers" do

		before do 
			@user = create(:blogger)
			sign_in @user
		end
		scenario "can create new slides" do
			visit blog_admin_en_path
			click_link "New Slide"
			fill_in "slide[en_title]", with: "Title"
			fill_in "slide[ko_title]", with: "It's korean"
			fill_in "slide[en_description]", with: "Some stuff"
			fill_in "slide[ko_description]", with: "Some korean stuff"
			check "slide[active]"
			fill_in "slide[link]", with: "http://nytimes.com"
			click_button "Create Slide"
			expect(page).to have_content("Slide created")
		end

		scenario "can edit slides" do
			@slide = create(:slide)
			visit blog_admin_en_path
			click_link @slide.id
			check "slide[active]"
			click_button "Update Slide"
			expect(page).to have_content("Slide updated")
		end

		scenario "can delete slides" do
			@slide = create(:slide)
			visit blog_admin_en_path
			click_link @slide.id
			click_link "Delete slide"
			expect(page).to have_content("Slide deleted")
		end
	end

	context "public users" do
		before do 
			@slide = create(:slide, active: true)
		end

		scenario "cannot edit slides" do
			visit edit_slide_path(@slide)
			expect(page).to have_content("Sorry")
		end

		scenario "cannot create slides" do
			visit new_slide_path
			expect(page).to have_content("Sorry")
		end

		scenario "can view slides on homepage" do
			visit root_path
	  	expect(page).to have_content @slide.ko_title
	  	expect(page).to have_content @slide.ko_description
	  end
	end

	context "regular users" do
		before do
			@slide = create(:slide)
			@user = create(:user)
			sign_in @user
		end

		scenario "cannot access slide controller" do
			visit new_slide_path
			expect(page).to have_content("Sorry")
		end
	end
end