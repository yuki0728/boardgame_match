class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  # 画像アップロードの設定
  mount_uploader :img, ImgUploader

  # ユーザフォロー機能の設定
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

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

  # ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # ユーザーをアンフォローする
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # ゲストユーザでログインする
  def self.guest
    find_or_create_by!(
      username: 'ゲスト',
      email: 'guest@example.com',
    ) do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  # 存在する住所かチェック
  def check_the_address_exists
    if address.present? && longitude.nil? && latitude.nil?
      errors.add(:address, "が存在していません")
    end
  end
end
