require 'spec_helper'

feature 'editing the photo of the month' do
  before do
    @user = create(:admin_user)
    @page = create(:page)
  end
  
  scenario 'admin users can edit the form' do
    sign_in @user
    visit photo_en_path
    click_link "Update Contest"
    fill_in 'page[body]', with: '<a href="nytimes.com">submit a photo</a>'
    click_button 'Update Page'
    expect(page).to have_content('Updated the page')
  end
  
  scenario "regular users can't edit the form" do
    visit photo_en_path
    expect(page).to_not have_content('Update Contest')
  end
end