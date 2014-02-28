require "spec_helper"

feature "Editing bands" do
  before do
    @band = create(:band)
    @user = create(:admin_user)
  end
  
  scenario "Admin users can edit bands" do
    sign_in @user
    visit edit_band_path(@band)
    fill_in 'Name', with: "PSY"
    click_button "Update"
    expect(page).to have_content('Band updated!') 
  end
end