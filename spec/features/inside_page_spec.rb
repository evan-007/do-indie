require 'spec_helper'

feature "Inside page" do
	before do
		@user = create(:user)
		@band = create(:band)
		@venue = create(:venue)
		@event = create(:event, date: Date.tomorrow, bands: [@band], venue: @venue)
	end

	context "for regular users" do
		scenario "shows liked venues" do
			@like = create(:venue_fan, user:@user, venue: @venue)
			sign_in @user
			expect(page).to have_content @venue.name
		end

		scenario "shows like bands" do
			@like = create(:user_fan, user:@user, band: @band)
			sign_in @user
			expect(page).to have_content @band.name
		end

		scenario "shows liked bands' upcoming events" do
			@like = create(:user_fan, user:@user, band: @band)
			sign_in @user
			expect(page).to have_content @event.name
		end
	end

	context "for managers" do

		scenario "shows managed events" do
			@manager = create(:event_manager, event: @event, user: @user, approved: true)
			sign_in @user
			expect(page).to have_content @event.name
		end

		scenario "show managed venues" do
			@manager = create(:venue_manager, venue: @venue, user: @user, approved: true)
			sign_in @user
			expect(page).to have_content @venue.name
		end

		scenario "show managed bands" do
			@manager = create(:band_manager, band: @band, user: @user, approved: true)
			sign_in @user
			expect(page).to have_content @band.name
		end
	end
end