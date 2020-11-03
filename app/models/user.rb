class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  validates :username, presence: true

  # 画像アップロードの設定
  mount_uploader :img, ImgUploader

  # 主催イベント
  has_many :events

  # コメント
  has_many :comments

  # 参加イベント
  has_many :participations, dependent: :destroy
  has_many :participate_events, through: :participations, source: :event
end
