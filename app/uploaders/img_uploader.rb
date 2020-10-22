class ImgUploader < CarrierWave::Uploader::Base
  # リサイズしたり画像形式を変更するのに必要
  include CarrierWave::RMagick

  # 開発環境と本番環境で保存先を分ける
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # 画像の上限を700pxにする
  process :resize_to_limit => [700, 700]

  # 保存形式をJPGにする
  process :convert => 'jpg'

  # サムネイルを生成する設定
  version :thumb do
    process :resize_to_limit => [300, 300]
  end

  # jpg,jpeg,gif,pngしか受け付けない
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # ファイル名を日付で保存する
  def filename
    time = Time.now
    name = time.strftime('%Y%m%d%H%M%S') + '.jpg'
    name.downcase
  end

  def store_dir
    if Rails.env.test? #テスト画像は一括削除できるようにフォルダを別にする
      "uploads_#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end
end
