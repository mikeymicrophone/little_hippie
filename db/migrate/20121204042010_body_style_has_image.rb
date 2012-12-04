class BodyStyleHasImage < ActiveRecord::Migration
  def up
    add_column :body_styles, :image, :string
  end

  def down
    remove_column :body_styles, :image
  end
end
