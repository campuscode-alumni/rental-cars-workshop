class AddDatesToRental < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :scheduled_start, :date
    add_column :rentals, :scheduled_end, :date
    add_column :rentals, :started_at, :datetime
    add_column :rentals, :ended_at, :datetime
  end
end
