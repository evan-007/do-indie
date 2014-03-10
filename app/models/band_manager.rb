class BandManager < ActiveRecord::Base
  belongs_to :user
  belongs_to :band
  scope :approved, -> { where(approved: true) }

  def self.search_and_order(search, page_number)
    if search
      where("username LIKE ?", "%#{search.downcase}%").order(
      admin: :desc, username: :asc
      ).page page_number
    else
      order(approved: :asc, user_id: :asc).page page_number
    end
  end
end
