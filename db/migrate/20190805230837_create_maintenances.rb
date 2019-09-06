class CreateMaintenances < ActiveRecord::Migration[5.2]
  def change
    create_table :maintenances do |t|
      t.references :car, foreign_key: true
      t.references :provider, foreign_key: true

      t.timestamps
    end
  end
end
