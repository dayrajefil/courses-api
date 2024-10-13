class CoursesController < ApplicationController
  def index
    courses = Course.where('end_date >= ?', Date.today)
    render json: courses #, include: :videos
  end
end
