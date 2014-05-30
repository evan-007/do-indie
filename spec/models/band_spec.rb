require 'spec_helper'

describe Band do
  it "has a upcoming_events scope that returns its upcoming events" do
    @band = create(:band)
    @event = create(:event, band_ids: [@band.id], date: Date.yesterday)
    @event2 = create(:event, band_ids: [@band.id], date: Date.tomorrow)
    @band.upcoming_events.should include @event2
    @band.upcoming_events.should_not include @event1
  end
end