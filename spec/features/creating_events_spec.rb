require "spec_helper"

feature "Creating events" do
	before do
		@user = create(:admin_user)
		@band = create(:band)
		@venue = create(:venue)
		@city = create(:city)
	end

	scenario "Users can create events" do
		sign_in @user
		visit new_event_en_path
		fill_in "event[name]", with: "Best party ever"
		fill_in "event[contact]", with: "010 -1234-1234"
		fill_in "event[price]", with: "1million wons"
		fill_in "event[info]", with: "Dress to impress, doors open at 9. Gangnam exit 4"
		fill_in "event[venue_tokens]", with: @venue.id
		select @city.en_name, from: "event[city_id]"
		click_button "Create Event"
		expect(page).to have_content("Thanks")
	end

	scenario "Users can see events they created on the sign in page" do
		@event = create(:event, user: @user)
		sign_in @user
		expect(page).to have_content(@event.name)
	end

	scenario "Non-authenticated users can't add events" do
		visit new_event_en_path
		expect(page).to have_content("sign up for a doindie account")
	end
  
	scenario "New bands can be added to an event"  #do
	#     sign_in @user
	#     visit new_event_en_path
	#     fill_in "event[name]", with: "partyyyyy"
	#     fill_in "event_band_tokens", with: "my new band"
	#     find("#event_band_tokens").native.send_keys(:return)
	#     click_button "Create Event"
	#     expect(page).to have_content("Thanks")
	#     expect(Band.last.name).to eq('my new band')
	# end

	scenario "New venues can be added to an event" #do
	# 	sign_in @user
	# 	visit new_event_en_path
	# 	fill_in "event[name]", with: 'big party!'
	# 	find('#add_venue').click
	# 	sleep(3)
	# 	fill_in "event_venue_attributes_name", with: "my new venue"
	# 	# select 'Seoul', from: "event_venue_attributes_city"
	# 	click_button "Create Event"
	# 	expect(page).to have_content('Thanks')
	# 	expect(Venue.last.name).to eq('my new venue')
	# end 
end