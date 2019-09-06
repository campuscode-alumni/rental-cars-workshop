class FinesController < ApplicationController
  def new
    @car = Car.find(params[:car_id])
    @fine = Fine.new
  end

  def create
    @car = Car.find(params[:car_id])
    @fine = @car.fines.new(fine_params)
    if @fine.save
      @fine.create_credit(amount: @fine.fine_value,
                          subsidiary: current_user.subsidiary)
      flash[:notice] = t '.success'
      redirect_to car_fine_path(@car, @fine)
    else
      flash.now[:error] = t '.error'
      render :new
    end
  end

  def show
    @fine = Fine.find(params[:id])
  end

  private

  def fine_params
    params.require(:fine).permit(:issued_on, :demerit_points, :fine_value,
                                 :address)
  end
end
