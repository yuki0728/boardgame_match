class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :user_id, presence: true, :uniqueness => {:scope => :event_id}
  validates :event_id, presence: true
  validate :check_number_of_participant

  def check_number_of_participant
    # 参加人数がsave前に評価されるため上限と同じ場合もエラーにする
    if event.participant_limit && event.participant_limit <= event.participate_users.count
      errors.add(:participant_limit, "が参加人数より少ないです")
    end
  end

  # 参加、不参加時にオーナーに通知する
  def notify_owner_by(user, action)
    temp = Notification.where(["event_id = ? and visited_id = ? and action = ? ", event_id, event.user.id, action])
    if temp.blank?
      notification = user.active_notifications.new(
        event_id: event_id,
        visited_id: event.user.id,
        action: action
      )
      notification.save if notification.valid?
    end
  end
end
