require 'spec_helper'

feature "Adding bands" do
  before do
      @user = create(:admin_user)
      sign_in @user
  end
  
  scenario "Admin users can add bands" do  
    visit new_band_path
    fill_in 'name', with: "Psy"
    fill_in 'phone', with: "010-1234-5678"
    click_button('submit')
    expect(page).to have_content("Band created!")
  end
end