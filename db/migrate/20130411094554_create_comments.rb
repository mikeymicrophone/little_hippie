class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :product
      t.belongs_to :customer
      t.text :message
      t.integer :moderated_by
      t.integer :position

      t.timestamps
    end
    add_index :comments, :product_id
    add_index :comments, :customer_id
  end
end
