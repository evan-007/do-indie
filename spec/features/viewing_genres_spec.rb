require "spec_helper"

feature "Viewing genres" do
	before do
		@band = create(:band)
		@genre = create(:genre)
		@band_genre = create(:band_genre, band_id: @band.id, genre_id: @genre.id)
	end

	scenario "public users can view bands by genre" do
		visit bands_en_path
		click_link @genre.name
		expect(page).to have_content (@band.name)
	end
end