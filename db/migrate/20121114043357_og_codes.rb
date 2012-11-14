class OgCodes < ActiveRecord::Migration
  def up
    add_column :product_colors, :og_code, :string
  end

  def down
    remove_column :product_colors, :og_code
  end
end
