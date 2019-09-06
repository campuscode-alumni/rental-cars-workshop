class AddInvoiceAndServiceCostToMaintenance < ActiveRecord::Migration[5.2]
  def change
    add_column :maintenances, :invoice, :string
    add_column :maintenances, :service_cost, :decimal
  end
end
