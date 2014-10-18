class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.belongs_to :customer, index: true
      t.belongs_to :department, index: true
      t.belongs_to :status, index: true
      t.string :subject
      t.text :body
      t.belongs_to :staff, index: true

      t.timestamps
    end
  end
end
