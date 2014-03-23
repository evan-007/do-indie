class EventManager < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  scope :approved, -> { where(approved: true) }
  after_create :approval_notification
  after_save :approval_notification, if: :approved_changed?

  def self.search_and_order(search, page_number)
    if search
      where("username LIKE ?", "%#{search.downcase}%").order(
      admin: :desc, username: :asc
      ).page page_number
    else
      order(approved: :asc, user_id: :asc).page page_number
    end
  end

  private

    def approval_notification
        if self.approved == true && self.user != nil
          UserMailer.event_manager_approved(self).deliver
        end
    end

end
