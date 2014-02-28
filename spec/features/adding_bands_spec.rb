feature "Adding bands" do
  scenario "Admin users can add bands" do
    before do
      @user = create(:admin_user)
      sign_in_as!(@user)
    end
    
    visit new_band_path
    fill_in('name'), with: "Psy"
    fill_in('phone'), with: "010-1234-5678"
    click_button('submit')
    expect(page).to have_content("Band created!")
  end
end