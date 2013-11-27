class CartHasTrackingNumber < ActiveRecord::Migration
  def up
    add_column :carts, :tracking_number, :string
  end

  def down
    remove_column :carts, :tracking_number
  end
end
