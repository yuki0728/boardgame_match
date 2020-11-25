class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  # 画像アップロードの設定
  mount_uploader :img, ImgUploader

  # 主催イベントの設定
  has_many :events

  # コメントの設定
  has_many :comments

  # 経緯度及び住所の設定
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # 参加イベントの設定
  has_many :participations, dependent: :destroy
  has_many :participate_events, through: :participations, source: :event

  # 経緯度及び住所の設定
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # 通知の設定
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  # バリデーション
  validates :username, presence: true
  validate :check_the_address_exists

  # 存在する住所かチェック
  def check_the_address_exists
    if address.present? && longitude.nil? && latitude.nil?
      errors.add(:address, "が存在していません")
    end
  end
end
