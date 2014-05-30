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
  
  scenario "band pages show upcoming events" do
    @event = create(:event, band_ids: [@band.id], date: Date.tomorrow, approved: true)
    @event2 = create(:event, name: 'eventnumber2', band_ids: [@band.id], date: Date.yesterday, approved: true)
    visit band_en_path(@band)
    expect(page).to have_content @event.name
    expect(page).to_not have_content @event2.name
  end
end