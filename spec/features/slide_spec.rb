require "spec_helper"

feature "Homepage slides" do 
	before do 
		@slide = create(:slide, active: true)
	end
	scenario "show active slides" do
		visit root_path
	  	expect(page).to have_content @slide.ko_title
	  	expect(page).to have_content @slide.link
	  	expect(page).to have_content @slide.ko_description
	end
end