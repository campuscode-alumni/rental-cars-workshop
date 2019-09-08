class AddStiAttrsToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :type, :string
    add_column :customers, :cnpj, :string
    add_column :customers, :fantasy_name, :string
  end
end
