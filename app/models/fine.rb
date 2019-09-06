class Fine < ApplicationRecord
  belongs_to :car
  has_one :credit, as: :transactable, dependent: :destroy

  validates :issued_on, :demerit_points, :fine_value, :address, presence: true
end
