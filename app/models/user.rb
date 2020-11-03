class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  validates :username, presence: true

  # 画像アップロードの設定
  mount_uploader :img, ImgUploader

  # 主催イベントの設定
  has_many :events

  # コメントの設定
  has_many :comments

  # 参加イベントの設定
  has_many :participations, dependent: :destroy
  has_many :participate_events, through: :participations, source: :event

  # 通知の設定
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
end
