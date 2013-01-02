class ColorHasCode < ActiveRecord::Migration
  def up
    add_column :colors, :css_hex_code, :string
  end

  def down
    remove_column :colors, :css_hex_code
  end
end
