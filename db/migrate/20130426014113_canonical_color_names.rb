class CanonicalColorNames < ActiveRecord::Migration
  def up
    add_column :colors, :canonical_color_names, :text
  end

  def down
    remove_column :colors, :canonical_color_names
  end
end
