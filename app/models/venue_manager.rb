class VenueManager < ActiveRecord::Base
  belongs_to :user
  belongs_to :venue
  scope :approved, -> { where(approved: true) }
end
