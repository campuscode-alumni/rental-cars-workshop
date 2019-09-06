class AddSubsidiaryRefToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :subsidiary, foreign_key: true
  end
end
