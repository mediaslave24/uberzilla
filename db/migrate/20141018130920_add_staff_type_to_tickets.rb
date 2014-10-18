class AddStaffTypeToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :staff_type, :string
  end
end
