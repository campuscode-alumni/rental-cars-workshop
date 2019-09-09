class Rental < ApplicationRecord
  belongs_to :car
  belongs_to :user
  belongs_to :customer

  validates :scheduled_start, :scheduled_end, presence: true
  validate :customer_cannot_rental_twice

  enum status: { scheduled: 0, active: 5, finished: 10 }

  private

  def customer_cannot_rental_twice
    return unless customer.personal_customer?
    return unless customer.active_rental

    errors.add(:customer_id, 'Cliente possui locação em aberto')
  end
end
