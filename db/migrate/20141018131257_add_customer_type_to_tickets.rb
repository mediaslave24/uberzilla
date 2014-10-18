class AddCustomerTypeToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :customer_type, :string
  end
end
