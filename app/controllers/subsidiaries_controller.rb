class SubsidiariesController < ApplicationController
  def show
    @subsidiary = Subsidiary.find(params[:id])
  end

  def new
    @subsidiary = Subsidiary.new
    @subsidiary.build_address
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    return redirect_to @subsidiary if @subsidiary.save

    render :new
  end

  private

  def subsidiary_params
    params.require(:subsidiary)
          .permit(:name, address_attributes: %i[id street number complement
                                                neighborhood city state])
  end
end
