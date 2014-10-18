class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password
      t.belongs_to :department, index: true
      t.string :type

      t.timestamps
    end
  end
end
