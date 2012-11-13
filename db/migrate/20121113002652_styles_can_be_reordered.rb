class StylesCanBeReordered < ActiveRecord::Migration
  def up
    add_column :body_styles, :position, :integer
    add_column :colors, :position, :integer
    add_column :designs, :position, :integer
    add_column :sizes, :position, :integer
  end

  def down
    remove_column :body_styles, :position
    remove_column :colors, :position
    remove_column :designs, :position
    remove_column :sizes, :position
  end
end
