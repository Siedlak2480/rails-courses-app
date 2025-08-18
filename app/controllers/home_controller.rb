class HomeController < ApplicationController
  def index
    # tutaj możesz przygotować dane dla dashboardu, np.
    @places_count = Place.count
    @courses_count = Course.count
    @participants_count = Participant.count
  end
end