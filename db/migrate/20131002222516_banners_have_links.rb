class BannersHaveLinks < ActiveRecord::Migration
  def up
    add_column :banners, :link, :string
  end

  def down
    remove_column :banners, :link
  end
end
