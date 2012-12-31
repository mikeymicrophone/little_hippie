class BodyStyleSizesPosition < ActiveRecord::Migration
  def up
    add_column :body_style_sizes, :position, :integer
  end

  def down
    remove_column :body_style_sizes, :position
  end
end
