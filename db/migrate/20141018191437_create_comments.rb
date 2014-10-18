class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.belongs_to :target, polymorphic: true
      t.belongs_to :author, polymorphic: true

      t.timestamps
    end
  end
end
