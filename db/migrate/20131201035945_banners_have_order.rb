class BannersHaveOrder < ActiveRecord::Migration
  def up
    add_column :banners, :position, :integer
  end

  def down
    remove_column :banners, :position
  end
end
