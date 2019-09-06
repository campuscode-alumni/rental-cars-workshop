class Subsidiary < ApplicationRecord
  has_one :address, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :cars, dependent: :destroy
  has_many :subsidiary_car_models, dependent: :destroy
  has_many :credits, dependent: :destroy
  has_many :transactions, dependent: :destroy
  accepts_nested_attributes_for :address

  validates :name, presence: true

  def current_price(car_model)
    current_price_car = subsidiary_car_models.where(car_model: car_model).last
    return current_price_car.price if current_price_car

    raise 'Esse carro não possui preço'
  end
end
