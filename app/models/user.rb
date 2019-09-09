class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  enum role: { employee: 0, manager: 5, admin: 10 }

  belongs_to :subsidiary

  has_many :rentals, dependent: :destroy
  has_many :inspections, dependent: :destroy

  def subsidiary?(sub)
    self.subsidiary == sub
  end
end
