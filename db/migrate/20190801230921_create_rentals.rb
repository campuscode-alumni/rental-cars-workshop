class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.references :car, foreign_key: true
      t.references :user, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
