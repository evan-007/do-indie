require 'spec_helper'

feature "Advertisements" do
	context "admin users" do

		before do 
			@user = create(:admin_user)
			sign_in @user
		end

		scenario "can create ads in the admin panel" do
			visit admin_root_en_path
			click_link "Ads"
			click_link "New Ad"
			fill_in "ad[link]", with: "http://nytimes.com"
			click_button "Create Ad"
			expect(page).to have_content("Ad created")
		end

		scenario "can edit ads" do
			@ad = create(:ad)
			visit admin_root_en_path
			click_link "Ads"
			click_link @ad.id
			fill_in "ad[link]", with: "https://bbc.co.uk"
			click_button "Update Ad"
			expect(page).to have_content("Ad updated")
		end
		scenario "can delete ads" do
			@ad = create(:ad)
			visit admin_root_en_path
			click_link "Ads"
			click_link @ad.id
			click_link "Delete"
			expect(page).to have_content('Ad deleted')
		end
	end

	context "Public users" do 
		before do
			@ad = create(:ad)
			@post = create(:post)
		end

		scenario "see ads on blog posts" do
			visit blog_path
			click_link @post.title
			expect(page).to have_css(".ad")
		end

		scenario "see ads on blog index" do
			visit blog_path
			expect(page).to have_css(".ad")
		end
	end
end