class BodyStyleSizePrice < ActiveRecord::Migration
  def up
    add_column :body_style_sizes, :price, :integer
  end

  def down
    remove_column :body_style_sizes, :price
  end
end
