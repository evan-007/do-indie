class Post < ActiveRecord::Base
  scope :published, -> { where(published: true) }
  extend FriendlyId
  friendly_id :title, use: :slugged
end
