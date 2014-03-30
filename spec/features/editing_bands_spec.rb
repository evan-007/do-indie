require "spec_helper"

feature "Editing bands" do
  before do
    @band = create(:band)
    @admin = create(:admin_user)
    @user = create(:user)
  end
  
  scenario "Admin users can edit bands" do
    sign_in @admin
    visit edit_band_en_path(@band)
    fill_in 'band[name]', with: "PSY"
    click_button "Update Band"
    expect(page).to have_content('Band updated!') 
  end
  
  scenario "managers can edit bands" do
    @manager = create(:band_manager, user: @user, band: @band)
    sign_in @user
    visit edit_band_en_path(@band)
    fill_in 'band[name]', with: "PSY"
    click_button "Update Band"
    expect(page).to have_content('Band updated!') 
  end
  
  scenario "non-managers cannot edit bands" do
    sign_in @user
    visit edit_band_en_path(@band)
    expect(page).to have_content("Sorry")
  end
end
  
  