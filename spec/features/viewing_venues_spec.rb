require "spec_helper"

feature "Viewing venues" do
  before do 
    @venue = create(:venue)
  end
  
  scenario "public users can view venues" do
    visit root_path
    click_link "Venues"
    click_link @venue.name
    expect(page).to have_content (@venue.name)
  end
end