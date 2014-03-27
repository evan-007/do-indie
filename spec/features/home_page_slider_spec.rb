require "spec_helper"

feature "Homepage slider" do
  
  scenario "sliders are shown on main page" do
    @slider = create(:slider)
    visit root_path
    expect(page).to have_content(@slider.ko_title)
  end
end