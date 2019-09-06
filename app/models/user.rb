class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable
  # and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  belongs_to :subsidiary

  has_many :rentals, dependent: :destroy
  has_many :inspections, dependent: :destroy
end
