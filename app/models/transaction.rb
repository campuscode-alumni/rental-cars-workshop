class Transaction < ApplicationRecord
  belongs_to :transactable, polymorphic: true
  belongs_to :subsidiary
end
