require "spec_helper"

feature "Admin genres panel" do
	before do
		@admin = create(:admin_user)
		@genre = create(:genre)
		sign_in @admin
	end

	scenario "Admin users can create genres" do
		visit admin_root_en_path
		click_link "Genres"
		click_link "Add genre"
		fill_in "genre[name]", with: "ug k-pop"
		click_button "Create Genre"
		expect(page).to have_content("created")
	end

	scenario "Admin users can edit genres" do
		visit admin_root_en_path
		click_link "Genres"
		click_link @genre.name
		fill_in "genre[name]", with: "terrible"
		click_button "Update Genre"
		expect(page).to have_content("updated")
	end

	scenario "Admin users can delete genres" do
		visit admin_root_en_path
		click_link "Genres"
		click_link @genre.name
		click_link "Delete genre"
		expect(page).to have_content("destroyed")
	end
end