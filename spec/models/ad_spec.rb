require 'spec_helper'

describe Ad do
	it "is not valid without a link" do
		expect(Ad.create).to_not be_valid
	end
end
