require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:course) }
    it { is_expected.to have_one_attached(:file) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:file) }
  end

  describe 'callbacks' do
    let(:course) { create(:course) }
    let(:file) { fixture_file_upload(Rails.root.join('spec/fixtures/videos/sample_video.mp4'), 'video/mp4') }

    context 'when a file is attached' do
      it 'sets the video size after saving' do
        video = Video.create!(course: course, file: file)
        expect(video.size_in_mb).to be_within(0.01).of(2.52)
      end

      it 'sets the URL after saving a new record' do
        video = build(:video, course: course, file: file)
        video.save

        expect(video.reload.url).to eq("course.mp4")
      end
    end

    context 'when no file is attached' do
      it 'does not set video size or URL' do
        video = Video.create(course: course)
        expect(video.size_in_mb).to be_nil
        expect(video.url).to be_nil
      end
    end
  end

  describe '#filename' do
    let(:course) { create(:course) }
    let(:file) { fixture_file_upload(Rails.root.join('spec/fixtures/videos/sample_video.mp4'), 'video/mp4') }

    it 'returns the filename of the attached file' do
      video = Video.create!(course: course, file: file)
      expect(video.filename).to eq('sample_video.mp4')
    end

    it 'returns nil if no file is attached' do
      video = Video.new(course: course)
      expect(video.filename).to be_nil
    end
  end
end
