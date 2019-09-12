class RentalsController < ApplicationController
  def show
    rental = Rental.find(params[:id])
    @rental = RentalPresenter.new(rental.decorate)
  end


  def new
    @rental = Rental.new
    @cars = current_user.subsidiary.cars
    @customers = Customer.all
  end

  def create
    @rental = current_user.rentals.new(rental_params)
    if @rental.save
      RentalMailer.send_rental_receipt(@rental.id).deliver_now
      flash[:notice] = 'Um email de confirmação foi enviado para o cliente'
      return redirect_to @rental
    end
    @cars = current_user.subsidiary.cars
    @customers = Customer.all
    render :new
  end

  def withdraw
    @rental = Rental.find(params[:id])
    @rental.started_at = Time.zone.now
    @rental.active!
    @rental.car.rented!
    redirect_to @rental
  end

  def new_car_return
    @car = Rental.find(params[:id]).car
  end

  def return_car
    @rental = Rental.find(params[:id])
    if RentalFinisher.new(@rental, params[:car][:car_km]).finish
      redirect_to @rental.car, notice: 'Carro devolvido com sucesso'
    else
      flash.now[:notice] = 'Nao foi possivel salvar'
      render :new_car_return
    end
  end

  def rental_by_period
    start = params[:report_start]
    finish = params[:report_end]

    @rentals = RentalByPeriodQuery.new(start..finish).call
  end


  private

  def rental_params
    params.require(:rental).permit(:car_id, :customer_id, :scheduled_start,
                                   :scheduled_end)
  end
end
