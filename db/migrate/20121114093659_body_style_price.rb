class BodyStylePrice < ActiveRecord::Migration
  def up
    add_column :body_styles, :base_price, :integer
  end

  def down
    remove_column :body_styles, :base_price
  end
end
