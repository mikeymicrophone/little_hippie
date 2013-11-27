class ColorsCanBeFeatured < ActiveRecord::Migration
  def up
    add_column :colors, :featured, :boolean
  end

  def down
    remove_column :colors, :featured
  end
end
