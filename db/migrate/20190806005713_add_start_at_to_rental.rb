class AddStartAtToRental < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :start_at, :datetimes
  end
end
