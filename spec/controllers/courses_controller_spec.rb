# spec/controllers/courses_controller_spec.rb
require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let!(:course) { create(:course) }

  describe 'GET #index' do
    it 'returns a list of courses' do
      get :index
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq([course.as_json])
    end
  end

  describe 'GET #show' do
    it 'returns the course details' do
      get :show, params: { id: course.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq(course.as_json(include: {
        videos: {
          only: [:id],
          methods: [:filename, :size_in_mb, :url]
        }
      }))
    end

    it 'returns 404 for a non-existing course' do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { { title: 'New Course', description: 'A new course', start_date: Date.today, end_date: Date.tomorrow } }

      it 'creates a new course' do
        expect {
          post :create, params: { course: valid_attributes }
        }.to change(Course, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('success' => 'Criado com sucesso!')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { title: '', description: 'Invalid course' } }

      it 'does not create a new course' do
        expect {
          post :create, params: { course: invalid_attributes }
        }.not_to change(Course, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('errors')
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:new_attributes) { { title: 'Updated Course' } }

      it 'updates the requested course' do
        patch :update, params: { id: course.id, course: new_attributes }
        course.reload
        expect(course.title).to eq('Updated Course')
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('success' => 'Atualizado com sucesso!')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { title: '' } }

      it 'does not update the course' do
        patch :update, params: { id: course.id, course: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('errors')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the course' do
      course
      expect {
        delete :destroy, params: { id: course.id }
      }.to change(Course, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include('success' => 'Curso excluído com sucesso!')
    end

    it 'returns 404 for a non-existing course' do
      delete :destroy, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
    end
  end
end
