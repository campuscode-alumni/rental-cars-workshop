class Maintenance < ApplicationRecord
  belongs_to :car
  belongs_to :provider
  has_one :debit, as: :transactable, dependent: :destroy

  validates :invoice,
            :service_cost,
            presence: true,
            on: :update

  scope :cars_on_maintenance, lambda {
    joins(:car).where(cars: { status: :on_maintenance })
  }

  def car_return(params)
    if update(params)
      car.available!
      create_debit(amount: params[:service_cost],
                   subsidiary: car.subsidiary)
    else
      false
    end
  end
end
