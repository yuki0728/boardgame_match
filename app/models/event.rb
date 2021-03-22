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

  # 通知の設定
  has_many :notifications, dependent: :destroy

  # タグの設定
  acts_as_taggable

  # 経緯度及び住所の設定
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # イベント名、本文のValitation
  validates :name, length: { maximum: 100 }, presence: true
  validates :text, length: { maximum: 3000 }, presence: true
  # 開始、終了時間のValitation
  validates_datetime :ending_time, :after => :start_time # 開始日時 <　終了日時
  validates_datetime :start_time, :on => :create, :on_or_after => :now # 現在以降の日時である
  # 参加人数のValitation
  validate :check_number_of_participant_limit
  validates :participant_limit, numericality: { only_integer: true, greater_than: 0 }

  # イベント検索の設定
  scope :event_search, -> (search_params) do
    return if search_params.blank?

    valid_events(search_params[:exclusion]).
      name_like(search_params[:name]).
      find_by_tag(search_params[:tag_list]).
      find_by_start_time(search_params[:date]).
      sorting(search_params[:keyword])
  end

  # 有効なイベント(参加できるイベント)のみ取得
  scope :valid_events, -> (exclusion) {
    if exclusion
      where("participations_count < participant_limit AND start_time > ?", DateTime.current)
    end
  }
  # イベント名の検索
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  # タグの検索
  scope :find_by_tag, -> (tags) { tagged_with(tags, any: true) if tags.present? }
  # 開催日の検索
  scope :find_by_start_time, -> (date) {
    if date.present?
      where(start_time: date.to_date.midnight..(date.to_date.midnight + 1.day)).
        or(where(ending_time: date.to_date.midnight..(date.to_date.midnight + 1.day)))
    end
  }

  # 並び替え機能
  scope :sorting, -> (sort) { order(sort) }
  scope :sort_list, -> {
    {
      "開始日時が早い順" => "start_time ASC",
      "開始日時が遅い順" => "start_time DESC",
      "作成が古い順" => "updated_at ASC",
      "作成が新しい順" => "updated_at DESC",
    }
  }

  # 参加可能か？
  def possible_to_participate?
    if participant_limit.to_i <= participations_count.to_i && start_time > Time.current
      true
    else
      false
    end
  end

  # イベントのオーナーか？
  def owner?(user)
    user_id.equal? user.id unless user.nil?
  end

  # イベントの参加者か？
  def participated_by?(user)
    participations.where(user_id: user.id).exists? unless user.nil?
  end

  # 参加人数が上限を超えていないかチェック
  def check_number_of_participant_limit
    if participant_limit.to_i < participations_count.to_i
      errors.add(:participant_limit, "が参加人数より少ないです")
    end
  end
end
