require 'spec_helper'

describe User do

	it 'is invalid with a duplicate username' do
		User.create(username: 'evan')
		expect(User.create(username: 'evan')).not_to be_valid
	end

	it 'is valid with Korean characters' do
		expect(create(:user, username: '맛있어요')).to be_valid
	end

	it 'is valid with 3 characters' do
		expect(create(:user, username: '김민수')).to be_valid
	end

	it 'is valid with Korean characters in its email address' do
		expect(create(:user, email: '맛있어요@naver.com')).to be_valid
	end


	describe '.approved_manager?' do

		before do 
			@user = create(:user)
			@band = create(:band)
			@band_manager = create(:band_manager, user: @user, band: @band, approved: false)
		end

		context 'when the user is not approved' do
			it 'returns false' do
				expect(@user.approved_manager?(@band.id)).to eq false
			end
		end

		context 'when the user is approved' do
			it 'returns true' do
				@band_manager.update(approved: true)
				expect(@user.approved_manager?(@band.id)).to eq true
			end
		end
	end
end