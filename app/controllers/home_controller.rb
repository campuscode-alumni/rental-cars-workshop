class HomeController < ApplicationController
  def index
    @cars = Car.all
    @cars_on_maintenance = Car.where(status: :on_maintenance).first(10)
  end
end
