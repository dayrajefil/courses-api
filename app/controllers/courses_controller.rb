class CoursesController < ApplicationController
  def index
    courses = Course.where('end_date >= ?', Date.today)
    render json: courses
  end

  def show
    course = Course.find(params[:id])
    render json: course
  end

  def create
    course = Course.new(course_params)
    if course.save
      render json: { course: course, success: 'Criado com sucesso!'}, status: :created
    else
      render json: { errors: format_errors(course.errors) }, status: :unprocessable_entity
    end
  end

  def update
    course = Course.find(params[:id])
    if course.update(course_params)
      render json: { course: course, success: 'Atualizado com sucesso!'}, status: :ok
    else
      render json: { errors: format_errors(course.errors) }, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :start_date, :end_date)
  end

  def format_errors(errors)
    errors.map do |error|
      { attribute: error.attribute, message: error.message }
    end
  end
end
