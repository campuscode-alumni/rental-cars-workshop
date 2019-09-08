class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  belongs_to :subsidiary

  has_many :rentals, dependent: :destroy
  has_many :inspections, dependent: :destroy
end
