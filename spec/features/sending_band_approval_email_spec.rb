require "spec_helper"

feature "Band approval email" do
	before do
		@user = create(:user)
		@band = create(:band, user: @user)
	end

	scenario "Users get emails after band approval" do
		@band.update(approved: true)
		expect(open_last_email).to be_delivered_from "evan.u.lloyd@gmail.com"
		expect(open_last_email).to be_delivered_to @user.email
	end
end