class ProductHasLandingColor < ActiveRecord::Migration
  def up
    add_column :products, :landing_color_id, :integer
  end

  def down
    remove_column :products, :landing_color_id
  end
end
