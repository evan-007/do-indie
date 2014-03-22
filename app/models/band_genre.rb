class BandGenre < ActiveRecord::Base
  belongs_to :band
  belongs_to :genre
  # validates :band_id, presence: true
  # validates :genre_id, presence: true
end
