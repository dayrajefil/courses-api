class VideosController < ApplicationController
  def destroy
    video = find_video
    return unless video

    if video.destroy
      render json: { success: 'Vídeo excluído com sucesso!' }, status: :ok
    else
      render json: { error: 'Erro ao excluir o vídeo.' }, status: :unprocessable_entity
    end
  end

  private

  def find_video
    Video.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Vídeo não encontrado.' }, status: :not_found
    nil
  end
end
