class Video < ApplicationRecord
  belongs_to :course
  has_one_attached :file

  after_save :set_video_size, if: -> { file.attached? && !file.destroyed? }

  after_commit :set_url, if: -> { file.attached? && !file.destroyed? && !url.present? }

  validates :file, presence: true

  def filename
    file.blob.filename.to_s if file.attached?
  end

  private

  def set_video_size
    self.update_column(:size_in_mb, (file.byte_size.to_f / (1024 * 1024)).round(2))
  end

  def set_url
    self.update_column(:url, Rails.application.routes.url_helpers.rails_blob_url(file, host: ENV['BACKEND_URL'], only_path: false))
  end
end
