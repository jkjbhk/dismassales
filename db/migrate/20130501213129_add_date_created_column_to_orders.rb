class AddDateCreatedColumnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :date_created, :date
  end
end
