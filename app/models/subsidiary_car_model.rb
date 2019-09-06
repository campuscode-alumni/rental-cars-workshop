class SubsidiaryCarModel < ApplicationRecord
  belongs_to :subsidiary
  belongs_to :car_model

  validates :price, presence: { message: 'Preço não pode ficar em branco' }
end
