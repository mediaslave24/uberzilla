class AddDefaultToTicketStatuses < ActiveRecord::Migration
  def change
    add_column :ticket_statuses, :default, :boolean, default: false
  end
end
