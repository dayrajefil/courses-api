class CoursesController < ApplicationController
  def index
    courses = Course.where('end_date >= ?', Date.today)
    render json: courses
  end

  def show
    course = find_course
    return unless course

    render json: course.as_json(include: {
      videos: {
        only: [:id],
        methods: [:filename, :size_in_mb, :url]
      }
    })
  end

  def create
    course = Course.new(permitted_params)
    if course.save
      render json: { course: course, success: 'Criado com sucesso!'}, status: :created
    else
      render json: { errors: format_errors(course.errors) }, status: :unprocessable_entity
    end
  end

  def update
    course = find_course
    return unless course

    if course.update(permitted_params)
      render json: { course: course, success: 'Atualizado com sucesso!'}, status: :ok
    else
      render json: { errors: format_errors(course.errors) }, status: :unprocessable_entity
    end
  end

  def destroy
    course = find_course
    return unless course

    if course.destroy
      render json: { success: 'Curso excluído com sucesso!' }, status: :ok
    else
      render json: { error: 'Erro ao excluir o curso.' }, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.require(:course).permit(:title, :description, :start_date, :end_date,
      videos_attributes: [:id, :file, :_destroy]
    )
  end

  def find_course
    Course.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Curso não encontrado.' }, status: :not_found and return
    nil
  end

  def format_errors(errors)
    errors.map do |error|
      { attribute: error.attribute, message: error.message }
    end
  end
end
