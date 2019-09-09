class HomeController < ApplicationController
  def index
    @scheduled_rentals = Rental.scheduled
    @active_rentals = Rental.active
    @available_cars = Car.available
    @cars_on_maintenance = Car.where(status: :on_maintenance).first(10)
  end
end
