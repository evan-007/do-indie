require 'spec_helper'

feature 'Liking venues' do
  before do
    @venue = create(:venue)
  end
  
  context "Authenticated user" do
    before do
      @user = create(:user)
      sign_in @user
    end

    scenario 'can like a venue from the index page' do
      visit venues_en_path
      click_link 'Like'
      expect(page).to have_content ("You are a fan")
    end
  
    scenario "can like a venue from Venu#show" do
      visit venue_en_path(@venue)
      click_link 'Like'
      expect(page).to have_content ("You are a fan")
    end

    scenario "can unlike a venue at venues#index" do
      @fan = create(:venue_fan, user: @user, venue: @venue)
      visit venues_en_path
      click_link 'Unlike'
      expect(page).to have_content ("You are no longer")
    end
  
    scenario "can unlike a venue at venue#show" do
      @fan = create(:venue_fan, user: @user, venue: @venue)
      visit venues_en_path
      click_link 'Unlike'
      expect(page).to have_content ("You are no longer")
    end
    
    scenario "cannot like a venue multiple times"
  end
  
  context "Unauthenticated user" do

    scenario "cannot like a venue" do
      visit venues_en_path
      expect(page).to_not have_content('Like')
    end
  end
end