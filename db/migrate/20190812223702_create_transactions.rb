class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :type

      t.timestamps
    end
  end
end
