class Manufacture < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
