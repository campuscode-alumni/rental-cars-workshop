class PersonalCustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update]

  def show; end

  def new
    @customer = PersonalCustomer.new
  end

  def create
    @customer = PersonalCustomer.new(customer_params)
    if @customer.save
      redirect_to @customer
      flash[:success] = 'Cliente cadastrado com sucesso'
    else
      flash[:error] = 'Você deve preencher todos os campos'
      render :new
    end
  end

  def edit; end

  def update
    if @customer.update(customer_params)
      redirect_to @customer
      flash[:success] = 'Cliente editado com sucesso'
    else
      flash[:error] = 'Você deve preencher todos os campos'
      render :edit
    end
  end

  private

  def customer_params
    params.require(:personal_customer).permit(:name, :email, :cpf, :phone)
  end

  def set_customer
    @customer = PersonalCustomer.find(params[:id])
  end
end
