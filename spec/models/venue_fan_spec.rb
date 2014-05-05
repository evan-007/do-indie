require 'spec_helper'

describe VenueFan do
  before do 
    @venue = create(:venue)
    @user = create(:user)
  end
  
  it "is not valid without a user" do
    expect(VenueFan.create(venue_id: @venue)).to_not be_valid
  end
    
  it "is not valid without a venue" do
    expect(VenueFan.create(user_id: @user)).to_not be_valid
  end
end
