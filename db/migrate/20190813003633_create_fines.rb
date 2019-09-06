class CreateFines < ActiveRecord::Migration[5.2]
  def change
    create_table :fines do |t|
      t.date :issued_on
      t.integer :demerit_points
      t.float :fine_value
      t.string :address
      t.references :car, foreign_key: true

      t.timestamps
    end
  end
end
