class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :set_place, only: [:new, :create]

  def show
  @participants = @course.participants.order(created_at: :asc)
  @participant = Participant.new
  end

  def new
    @course = @place.courses.build
  end

  def create
    # jeśli wywołane jako /places/:place_id/courses
    if params[:place_id]
      @course = Place.find(params[:place_id]).courses.build(course_params)
    else
      @course = Course.new(course_params)
    end

    if @course.save
      redirect_to @course, notice: "Course created."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: "Course updated."
    else
      render :edit
    end
  end

  def destroy
  place = @course.place
  if @course.destroy
    respond_to do |format|
      format.html { redirect_to (place ? place_path(place) : places_path), notice: "Course removed." }
      format.json { head :no_content }
    end
  else
    respond_to do |format|
      format.html { redirect_to (place ? place_path(place) : places_path), alert: "Could not remove course." }
      format.json { render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity }
    end
  end
end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def set_place
    @place = Place.find(params[:place_id]) if params[:place_id].present?
  end

  def course_params
    params.require(:course).permit(:title, :description, :place_id)
  end
end

class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:edit, :update, :destroy]
  before_action :set_course, only: [:new, :create]

  def new
    @participant = @course.participants.build
  end

  # obsługa HTML i JSON (dla AJAX)
  def create
    @participant = @course.participants.build(participant_params)
    respond_to do |format|
      if @participant.save
        format.html { redirect_to course_path(@course), notice: "Participant added." }
        format.json { render json: @participant, status: :created }
      else
        format.html { render :new }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    if @participant.update(participant_params)
      redirect_to course_path(@participant.course), notice: "Participant updated."
    else
      render :edit
    end
  end

  def destroy
    course = @participant.course
    @participant.destroy
    redirect_to course_path(course), notice: "Participant removed."
  end

  private

  def set_participant
    @participant = Participant.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id]) if params[:course_id]
  end

  def participant_params
    params.require(:participant).permit(:name, :email, :course_id)
  end
end