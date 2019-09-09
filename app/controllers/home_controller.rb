class HomeController < ApplicationController
  def index
    @cars = Car.all
    @scheduled_rentals = Rental.scheduled
    @cars_on_maintenance = Car.where(status: :on_maintenance).first(10)
  end
end
