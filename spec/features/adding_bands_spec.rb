require 'spec_helper'

feature "Adding bands" do
  before do
      @user = create(:admin_user)
      @genre = create(:genre)
  end
  
  scenario "Authorized users can add bands with existing genres" do 
    sign_in @user
    visit new_band_en_path
    fill_in 'Name', with: "Psy"
    fill_in 'Korean name', with: 'ㅁㄴㅇㄹ'
    fill_in 'Contact', with: "010-1234-5678"
    select @genre.name, from: "Genre"
    click_button('Create Band')
    expect(page).to have_content("Band created!")
    expect(page).to have_content @genre.name
  end
 

  scenario "Authorized users can add bands with a new genre" do
    sign_in @user
    visit new_band_en_path
    fill_in 'Name', with: "Psy"
    fill_in 'Korean name', with: 'ㅁㄴㅇㄹ'
    fill_in 'Contact', with: "010-1234-5678"
    fill_in "new_genre", with: "Jazz"
    click_button('Create Band')
    expect(page).to have_content("Band created!")
    expect(page).to have_content("Jazz")
  end
    
  scenario "Non-authenticated users can't add bands" do
    visit new_band_en_path
    expect(page).to have_content("You need to sign in")
  end
end