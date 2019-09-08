class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show]

  def new; end

  def index
    @customers = Customer.all
  end

  def show; end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
