class InspectionsController < ApplicationController
  def new
    @car = Car.find(params[:car_id])
    @inspection = Inspection.new
  end

  def create
    @car = Car.find(params[:car_id])
    @inspection = Inspection.new(inspection_params)
    @inspection.user = current_user
    @inspection.car = @car
    @inspection.car.available!
    return redirect_to @car if @inspection.save

    render :new
  end

  private

  def inspection_params
    params.require(:inspection).permit(:fuel_level, :cleanance_level, :damages)
  end
end
