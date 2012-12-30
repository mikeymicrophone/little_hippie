class CreateProductSizes < ActiveRecord::Migration
  def change
    create_table :product_sizes do |t|
      t.belongs_to :product
      t.belongs_to :size

      t.timestamps
    end
    add_index :product_sizes, :product_id
    add_index :product_sizes, :size_id
  end
end
