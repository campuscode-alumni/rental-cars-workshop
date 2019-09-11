class CarsController < ApplicationController

  def show
    car = Car.find(params[:id])
    @car = CarPresenter.new(car, current_user)
  end

  def new
    @car = Car.new
    @car_models = CarModel.all
  end

  def create
    @car = Car.new(car_params)
    @car.subsidiary = current_user.subsidiary
    return redirect_to @car if @car.save

    @car_models = CarModel.all
    render :new
  end

  def search
    @car = Car.find_by(license_plate: params[:q])
    return redirect_to @car if @car
    redirect_to root_path, notice: 'Nenhum carro encontrado'
  end

  private

  def car_params
    params.require(:car).permit(%i[car_model_id car_km color license_plate])
  end
end
