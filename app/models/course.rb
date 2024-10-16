class Course < ApplicationRecord
  has_many :videos, dependent: :destroy

  after_commit :calculate_total_size

  validates :title, :description, :start_date, :end_date, presence: true

  validate :end_date_after_start_date

  accepts_nested_attributes_for :videos

  private

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?

    if end_date < start_date
      errors.add(:end_date, "deve ser maior ou igual à data de início.")
    end
  end

  def calculate_total_size
    self.update_column(:total_size_in_mb, videos.sum(:size_in_mb) || 0.0)
  end
end
