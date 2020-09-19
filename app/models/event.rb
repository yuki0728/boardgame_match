class Event < ApplicationRecord
  # イベント主催者
  belongs_to :user

  # イベント参加者
  has_many :participations, dependent: :destroy
  has_many :participate_users, through: :participations, source: :user

  # タグの設定
  acts_as_taggable

  # イベント名、本文のValitation
  validates :name, length: { maximum: 100 }, presence: true
  validates :text, length: { maximum: 3000 }, presence: true
  # 開始、終了時間のValitation
  validates_datetime :ending_time, :after => :start_time # 開始日時 <　終了日時
  validates_datetime :start_time, :on => :create, :on_or_after => :today # 今日以降の日時である
  # 参加人数のValitation
  validate :check_number_of_participant_limit
  validates :participant_limit, presence: true,
                                numericality: { only_integer: true, greater_than: 0 }

  def check_number_of_participant_limit
    if participant_limit && participant_limit < participations.count
      errors.add(:participant_limit, "が参加人数より少ないです")
    end
  end

  def participated_by?(user)
    participations.where(user_id: user.id).exists?
  end
end
