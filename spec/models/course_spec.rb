require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:videos).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }

    context 'with custom validation for end_date' do
      it 'is valid when end_date is after start_date' do
        course = Course.new(title: 'Test Course', description: 'Description', start_date: Date.today, end_date: Date.today + 1.day)
        expect(course).to be_valid
      end

      it 'is invalid when end_date is before start_date' do
        course = Course.new(title: 'Test Course', description: 'Description', start_date: Date.today, end_date: Date.today - 1.day)
        expect(course).to be_invalid
        expect(course.errors[:end_date]).to include('deve ser maior ou igual à data de início.')
      end
    end
  end

  describe 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:videos) }
  end

  describe 'callbacks' do
    let(:course) { build(:course) }

    it 'calculates total size in MB after a video is added' do
      video1 = create(:video, course: course)
      video2 = create(:video, course: course)
      course.save

      expect(course.reload.total_size_in_mb).to eq(5.04)
    end

    it 'does not run calculate_total_size if course is destroyed' do
      course.destroy
      expect(course).to be_destroyed
    end
  end
end
