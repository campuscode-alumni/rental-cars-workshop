class MaintenancesController < ApplicationController
  def new
    @car = Car.find(params[:car_id])
    @maintenance = @car.maintenances.build
  end

  def create
    @maintenance = Maintenance.new
    @maintenance.car = Car.find(params[:car_id])
    @maintenance.provider = Provider.find(params[:maintenance][:provider_id])
    if @maintenance.save
      @maintenance.car.on_maintenance!
      flash[:notice] = I18n.t('maintenance.flash.create')
      redirect_to @maintenance.car
    end
  end

  def index
    @maintenances = Maintenance.cars_on_maintenance
  end

  def new_return
    @maintenance = Maintenance.find(params[:id])
  end

  def car_return
    @maintenance = Maintenance.find(params[:id])
    @car = @maintenance.car

    if @maintenance.car_return(maintenance_return_params)
      flash[:notice] = 'Carro disponível'
    else
      render :new_return
    end
  end

  private

  def maintenance_return_params
    params.require(:maintenance).permit(:invoice, :service_cost)
  end
end
