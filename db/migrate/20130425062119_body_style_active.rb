class BodyStyleActive < ActiveRecord::Migration
  def up
    add_column :body_styles, :active, :boolean
  end

  def down
    remove_column :body_styles, :active
  end
end
