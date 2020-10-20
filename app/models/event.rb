class Event < ApplicationRecord
  # イベント主催者
  belongs_to :user

  # コメント
  has_many :comments, dependent: :destroy

  # イベント参加者
  has_many :participations, dependent: :destroy
  has_many :participate_users, through: :participations, source: :user

  # 画像アップロードの設定
  mount_uploader :img, ImgUploader

  # タグの設定
  acts_as_taggable

  # イベント名、本文のValitation
  validates :name, length: { maximum: 100 }, presence: true
  validates :text, length: { maximum: 3000 }, presence: true
  # 開始、終了時間のValitation
  validates_datetime :ending_time, :after => :start_time # 開始日時 <　終了日時
  validates_datetime :start_time, :on => :create, :on_or_after => :now # 現在以降の日時である
  # 参加人数のValitation
  validate :check_number_of_participant_limit
  validates :participant_limit, numericality: { only_integer: true, greater_than: 0 }

  scope :event_search, -> (search_params) do
    return if search_params.blank?

    name_like(search_params[:name]).
      find_by_tag(search_params[:tag_list]).
      find_by_start_time(search_params[:date]).
      sorting(search_params[:keyword])
  end

  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :find_by_tag, -> (tags) { tagged_with(tags, any: true) if tags.present? }
  scope :find_by_start_time, -> (date) {
    if date.present?
      where(start_time: date.to_date.midnight..(date.to_date.midnight + 1.day)).
        or(where(ending_time: date.to_date.midnight..(date.to_date.midnight + 1.day)))
    end
  }

  scope :sorting, -> (selection) {
    case selection
    when 'new'
      order(start_time: :ASC)
    when 'old'
      order(start_time: :DESC)
    end
  }

  def owner?(user)
    user_id.equal? user.id
  end

  def check_number_of_participant_limit
    if participant_limit && participant_limit < participations.count
      errors.add(:participant_limit, "が参加人数より少ないです")
    end
  end

  def participated_by?(user)
    participations.where(user_id: user.id).exists?
  end
end
