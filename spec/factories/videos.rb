FactoryBot.define do
  factory :video do
    association :course
    url { "course.mp4" }
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/videos/sample_video.mp4'), 'video/mp4') }

    after(:build) do |video|
      video.file.attach(
        io: File.open(Rails.root.join('spec/fixtures/videos/sample_video.mp4')),
        filename: 'sample_video.mp4',
        content_type: 'video/mp4')
    end
  end
end
