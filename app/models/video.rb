class Video < ApplicationRecord
  belongs_to :course

  has_one_attached :file

  before_save :set_video_size

  validates :course_id, :file, presence: true

  def filename
    file.blob.filename.to_s if file.attached?
  end

  private

  def set_video_size
    if file.attached?
      self.size_in_mb = (file.byte_size.to_f / (1024 * 1024)).round(2)
    end
  end
end
