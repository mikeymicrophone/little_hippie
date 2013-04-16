class UnitPriceOfBodyStyleSize < ActiveRecord::Migration
  def up
    add_column :unit_prices, :body_style_size_id, :integer
  end

  def down
    remove_column :unit_prices, :body_style_size_id
  end
end
