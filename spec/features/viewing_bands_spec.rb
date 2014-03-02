require "spec_helper"

feature "Viewing bands" do
  before do
    @band = create(:band)
  end
  
  scenario "public users can view a list of bands" do
    visit bands_path
    click_link @band.name
    expect(page).to have_content (@band.name)
  end
end