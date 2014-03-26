class BannerStoresCustomerId < ActiveRecord::Migration
  def up
    add_column :banners, :customer_id, :integer
  end

  def down
    remove_column :banners, :customer_id
  end
end
