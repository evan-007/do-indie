class Slider < ActiveRecord::Base
  validates :en_title, :ko_title, presence: true 
  has_attached_file :image, :default_url => "/images/:style/missing.png"
  scope :active, -> { where(active: true).where(first: false) }
  scope :front, -> { where(first: true) }
end
