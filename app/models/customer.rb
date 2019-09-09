class Customer < ApplicationRecord
  has_many :rentals, dependent: :destroy
  validates :name, :email, :phone, presence: true

  def description
    "#{id} - #{name}"
  end

  def active_rental
    rentals.active.last
  end
end
