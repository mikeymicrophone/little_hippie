class BannersOrderedInGallery < ActiveRecord::Migration
  def up
    add_column :banners, :gallery_position, :integer
  end

  def down
    remove_column :banners, :gallery_position
  end
end
