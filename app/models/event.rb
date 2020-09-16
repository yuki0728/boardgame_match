class Event < ApplicationRecord
  # イベント主催者
  belongs_to :user

  # イベント参加者
  has_many :participations, dependent: :destroy
  has_many :participate_users, through: :participations, source: :user

  # タグの設定
  acts_as_taggable

  def participated_by?(user)
    participations.where(user_id: user.id).exists?
  end
end
