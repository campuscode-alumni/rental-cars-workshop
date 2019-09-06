class Provider < ApplicationRecord
  has_many :maintenances, dependent: :destroy
end
