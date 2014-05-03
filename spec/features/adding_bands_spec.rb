require 'spec_helper'

feature "Adding bands" do
  before do
      @user = create(:admin_user)
      @genre = create(:genre)
  end
  
  scenario "Authorized users can add bands with existing genres" do 
    sign_in @user
    visit new_band_en_path
    fill_in 'band[name]', with: "Psy"
    fill_in 'band[korean_name]', with: 'ㅁㄴㅇㄹ'
    fill_in 'band[contact]', with: "010-1234-5678"
    fill_in 'band[soundcloud]', with: "https://soundcloud.com/lukefair"
    fill_in "band_genre_tokens", with: @genre.id
    click_button('Create Band')
    expect(page).to have_content("Thanks")
    expect(page).to have_content @genre.name
  end
 

  scenario "Authorized users can add bands with a new genre"
    
  scenario "Non-authenticated users can't add bands" do
    visit new_band_en_path
    expect(page).to have_content("sign up")
  end

  scenario "Users can see bands they created on the signin page" do
    @user2 = create(:user)
    @band = create(:band, user: @user2)
    sign_in @user2
    expect(page).to have_content(@band.name)
  end
end