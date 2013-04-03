class BannerHasCaption < ActiveRecord::Migration
  def up
    add_column :banners, :caption, :string
  end

  def down
    remove_column :banners, :caption
  end
end
