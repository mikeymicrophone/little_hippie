class MwwProductAttributes < ActiveRecord::Migration
  def up
    add_column :product_colors, :mww_code, :string
    add_column :designs, :fabric_photo, :string
  end

  def down
    remove_column :product_colors, :mww_code
    remove_column :designs, :fabric_photo
  end
end
