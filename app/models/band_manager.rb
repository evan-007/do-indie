class BandManager < ActiveRecord::Base
  validates :user_id, :band_id, presence: true
  belongs_to :user, dependent: :destroy
  belongs_to :band, dependent: :destroy
  scope :approved, -> { where(approved: true) }
  after_create :approval_notification
  after_update :approval_notification, if: :approved_changed?

  def self.search_and_order(search, page_number)
    if search
      joins(:user).where("users.username LIKE ?", "%#{search.downcase}%").order(
      user_id: :desc
      ).page page_number
    else
      order(approved: :asc, user_id: :asc).page page_number
    end
  end

  private
      def approval_notification
        if self.approved == true && self.user != nil
          UserMailer.band_manager_approved(self).deliver
        end
      end
end
