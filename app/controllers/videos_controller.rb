class VideosController < ApplicationController
  def destroy
    video = Video.find(params[:id])
    if video.destroy
      render json: { success: 'Vídeo excluído com sucesso!' }, status: :ok
    else
      render json: { error: 'Erro ao excluir o vídeo.' }, status: :unprocessable_entity
    end
  end
end
