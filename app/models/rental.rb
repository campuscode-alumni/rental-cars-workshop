class Rental < ApplicationRecord
  belongs_to :car
  belongs_to :user
  belongs_to :customer

  validate :customer_cannot_rental_twice

  def customer_cannot_rental_twice
    return unless customer.rental?

    errors.add(:customer_id, 'Cliente possui locação em aberto')
  end
end
