class BodyStyleSizeHasWeight < ActiveRecord::Migration
  def up
    add_column :body_style_sizes, :weight, :float
  end

  def down
    remove_column :body_style_sizes, :weight
  end
end
