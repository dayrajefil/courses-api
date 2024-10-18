require 'rails_helper'

RSpec.describe 'Courses', type: :routing do
  it 'routes GET /courses/:id to courses#show' do
    expect(get: '/courses/1').to route_to(controller: 'courses', action: 'show', id: '1')
  end

  it 'routes GET /courses to courses#index' do
    expect(get: '/courses').to route_to(controller: 'courses', action: 'index')
  end

  it 'routes POST /courses to courses#create' do
    expect(post: '/courses').to route_to(controller: 'courses', action: 'create')
  end

  it 'routes PUT /courses/:id to courses#update' do
    expect(put: '/courses/1').to route_to(controller: 'courses', action: 'update', id: '1')
  end

  it 'routes DELETE /courses/:id to courses#destroy' do
    expect(delete: '/courses/1').to route_to(controller: 'courses', action: 'destroy', id: '1')
  end
end
