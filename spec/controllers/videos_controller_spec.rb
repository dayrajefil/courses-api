# spec/controllers/videos_controller_spec.rb
require 'rails_helper'

RSpec.describe VideosController, type: :controller do
  include FactoryBot::Syntax::Methods

  let!(:video) { create(:video) }
  let!(:course_id) { video.course_id }

  describe 'DELETE #destroy' do
    context 'when the video exists' do
      it 'deletes the video and returns success message' do
        delete :destroy, params: { course_id: course_id, id: video.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('success' => 'Vídeo excluído com sucesso!')
      end
    end

    context 'when the video does not exist' do
      it 'returns 404 for a non-existing video' do
        delete :destroy, params: { course_id: course_id, id: 9999 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to include('error' => 'Vídeo não encontrado.')
      end

      it 'returns 404 when id is nil' do
        expect {
          delete :destroy, params: { course_id: course_id, id: nil }
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end
end
