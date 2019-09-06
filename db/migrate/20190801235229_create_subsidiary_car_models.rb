class CreateSubsidiaryCarModels < ActiveRecord::Migration[5.2]
  def change
    create_table :subsidiary_car_models do |t|
      t.decimal :price
      t.references :subsidiary, foreign_key: true
      t.references :car_model, foreign_key: true

      t.timestamps
    end
  end
end
