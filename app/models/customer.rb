class Customer < ApplicationRecord
  has_many :rentals, dependent: :destroy
  validates :name, :email, :phone, presence: true

  def description
    "#{id} - #{name}"
  end

  def rental?
    rentals.where(rentals: { finished_at: nil }).count.positive?
  end
end
