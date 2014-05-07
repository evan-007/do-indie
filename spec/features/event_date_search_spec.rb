require "spec_helper"

feature "Event date search" do
  before do
    @event = create(:event, approved: true, date: "2014/05/06")
  end
  
  scenario "returns events that match the date" do
    visit events_en_path
    fill_out "date_search", with: "2014/05/06"
    click_button "Search"
    expect(page).to have_content(@event.name)
  end
  
  scenario "doesn't return events that don't match query" do
    visit events_en_path
    fill_out "date_search", with: "2014/04/04"
    click_button "Search"
    expect(page).to have_content("Sorry, no matches")
  end
end