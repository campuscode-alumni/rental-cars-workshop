class CarModelsController < ApplicationController
  def show
    @car_model = CarModel.find(params[:id])
  end

  def new
    @car_model = CarModel.new
    @manufactures = Manufacture.all
  end

  def create
    @car_model = CarModel.new(car_model_params)
    return redirect_to @car_model if @car_model.save

    @manufactures = Manufacture.all
    render :new
  end

  private

  def car_model_params
    params.require(:car_model).permit(%i[name year manufacture_id car_options])
  end
end
