class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :user_id, presence: true
  validates :event_id, presence: true
  validate :check_number_of_participant

  def check_number_of_participant
    # 参加人数がsave前に評価されるため上限と同じ場合もエラーにする
    if event.participant_limit && event.participant_limit <= event.participate_users.count
      errors.add(:participant_limit, "が参加人数より少ないです")
    end
  end
end
