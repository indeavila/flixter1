class LessonsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :require_authorized_for_current_lesson, only: [:show]
  def show
  end
  private
  def require_authorized_for_current_lesson
    unless current_user.enrolled_in?(current_lesson.section.course)
      redirect_to course_path(current_lesson.section.course), alert: 'Error: You Are Not Enrolled In This Course'
    end
  end
  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end