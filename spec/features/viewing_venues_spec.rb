require "spec_helper"

feature "Viewing venues" do
  before do 
    @venue = create(:venue)
  end
  
  scenario "public users can view approved venues" do
    visit venues_path
    click_link @venue.name
    expect(page).to have_content (@venue.name)
  end

  scenario "public users cannot view unapproved venues" do
  	@venue2 = create(:unapproved_venue)
  	visit venues_path
  	expect(page).to_not have_content @venue2.name
  end
end