class Course < ApplicationRecord
  has_many :videos, dependent: :destroy

  validates :title, :description, :start_date, :end_date, presence: true

  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?

    if end_date < start_date
      errors.add(:end_date, "deve ser maior ou igual à data de início.")
    end
  end
end
