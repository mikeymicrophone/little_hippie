class OversizePricing < ActiveRecord::Migration
  def up
    add_column :body_styles, :xxl_price, :integer
    add_column :body_styles, :xxxl_price, :integer
  end

  def down
    remove_column :body_styles, :xxl_price
    remove_column :body_styles, :xxxl_price
  end
end
