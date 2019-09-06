class CarModel < ApplicationRecord
  belongs_to :manufacture
  has_many :subsidiary_car_models, dependent: :destroy

  validates :name, :year, :car_options, presence: true
end
