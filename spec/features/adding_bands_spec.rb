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
    fill_in 'Soundcloud', with: "https://soundcloud.com/lukefair"
    select @genre.name, from: "band_genre_ids"
    click_button('Create Band')
    expect(page).to have_content("Band created")
    expect(page).to have_content @genre.name
  end
 

  scenario "Authorized users can add bands with a new genre" do
    sign_in @user
    visit new_band_en_path
    fill_in 'Name', with: "Psy"
    fill_in 'Korean name', with: 'ㅁㄴㅇㄹ'
    fill_in 'Contact', with: "010-1234-5678"
    fill_in "new_genre", with: "Jazz"
    fill_in 'Soundcloud', with: "https://soundcloud.com/lukefair"
    click_button('Create Band')
    expect(page).to have_content("Band created")
    expect(page).to have_content("Jazz")
  end
    
  scenario "Non-authenticated users can't add bands" do
    visit new_band_en_path
    expect(page).to have_content("You need to sign in")
  end

  scenario "Users can see bands they created on the signin page" do
    @user2 = create(:user)
    @band = create(:band, user: @user2)
    sign_in @user2
    expect(page).to have_content(@band.name)
  end
end