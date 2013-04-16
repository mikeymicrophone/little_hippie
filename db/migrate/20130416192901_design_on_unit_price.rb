class DesignOnUnitPrice < ActiveRecord::Migration
  def up
    add_column :unit_prices, :design_id, :integer
  end

  def down
    remove_column :unit_prices, :design_id
  end
end
