class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  validates :username, presence: true

  # 主催イベント
  has_many :events

  # 参加イベント
  has_many :participations, dependent: :destroy
  has_many :participate_events, through: :participations, source: :event
end
