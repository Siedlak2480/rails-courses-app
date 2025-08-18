class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  def index
    @places = Place.all.includes(:courses)
  end

  def show
  @place = Place.find(params[:id])
  # eager load participants count to avoid N+1
  @courses = @place.courses.left_joins(:participants)
                 .select('courses.*, COUNT(participants.id) AS participants_count')
                 .group('courses.id')
end

  def new
    @place = Place.new
  end

  def create
  @place = Place.new(place_params)

  if @place.save
    redirect_to @place, notice: "Place created."
  else
    render :new
  end
end

  def edit; end

  def update
    if @place.update(place_params)
      redirect_to @place, notice: "Place updated."
    else
      render :edit
    end
  end

  def destroy
  @place = Place.find(params[:id])
  if @place.destroy
    respond_to do |format|
      format.html { redirect_to places_path, notice: "Place removed." }
      format.json { head :no_content }
    end
  else
    respond_to do |format|
      format.html { redirect_to places_path, alert: "Could not remove place." }
      format.json { render json: { errors: @place.errors.full_messages }, status: :unprocessable_entity }
    end
  end
end

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name, :address)
  end
end