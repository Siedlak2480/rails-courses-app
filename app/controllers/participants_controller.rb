class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:edit, :update, :destroy]
  before_action :set_course, only: [:new, :create]

  def new
    @participant = @course.present? ? @course.participants.build : Participant.new
  end

  def create
  if @course
    @participant = @course.participants.build(participant_params)
  else
    @participant = Participant.new(participant_params)
  end

  respond_to do |format|
    if @participant.save
      # zwracamy tylko najważniejsze pola w JSON (bez nadmiarowych danych)
      format.html { redirect_to course_path(@participant.course || @course), notice: "Participant added." }
      format.json { render json: @participant.as_json(only: [:id, :name, :email, :course_id]), status: :created }
    else
      format.html { render :new }
      # zawsze zwracamy errors jako tablicę pod kluczem "errors"
      format.json { render json: { errors: @participant.errors.full_messages }, status: :unprocessable_entity }
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
    # supports nested route /courses/:course_id/participants
    @course = Course.find(params[:course_id]) if params[:course_id].present?
    # also allow course_id inside participant params (form hidden field)
    if @course.nil? && params.dig(:participant, :course_id).present?
      @course = Course.find_by(id: params[:participant][:course_id])
    end
  end

  def participant_params
    params.require(:participant).permit(:name, :email, :course_id)
  end
end
