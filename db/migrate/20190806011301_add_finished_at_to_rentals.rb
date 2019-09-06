class AddFinishedAtToRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :finished_at, :datetime
  end
end
