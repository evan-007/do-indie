require "spec_helper"

feature "Viewing bands" do
  before do
    @band = create(:band)
    Band.find_each(&:save)
  end
  
  scenario "public users can view a list of bands" do
    visit bands_en_path
    click_link @band.name
    expect(page).to have_content (@band.name)
  end

  scenario "only approved bands are listed" do
  	@band2 = create(:unapproved_band)
  	visit bands_path
  	expect(page).to_not have_content(@band2.name)
  end
end