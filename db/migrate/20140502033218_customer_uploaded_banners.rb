class CustomerUploadedBanners < ActiveRecord::Migration
  def up
    add_column :banners, :customer_uploaded, :boolean
  end

  def down
    remove_column :banners, :customer_uploaded
  end
end
