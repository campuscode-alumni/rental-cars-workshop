class AddStatusToCars < ActiveRecord::Migration[5.2]
  def up
    add_column :cars, :status, :integer, default: 0
  end

  def down
    remove_column :cars, :status, :integer, default: 0
  end
end
