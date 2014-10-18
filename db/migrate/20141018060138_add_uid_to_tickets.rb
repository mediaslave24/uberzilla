class AddUidToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :uid, :string
  end
end
