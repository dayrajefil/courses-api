require 'rails_helper'

RSpec.describe 'Videos Routes', type: :routing do
  it 'routes DELETE /courses/:course_id/videos/:id to videos#destroy' do
    expect(delete: '/courses/1/videos/1').to route_to(controller: 'videos', action: 'destroy', course_id: '1', id: '1')
  end
end
