class BannersActiveInGallery < ActiveRecord::Migration
  def up
    add_column :banners, :active_in_gallery, :boolean
  end

  def down
    remove_column :banners, :active_in_gallery
  end
end
