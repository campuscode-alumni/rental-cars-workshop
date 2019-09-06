class AddTransactableRefToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :transactable, polymorphic: true
  end
end
