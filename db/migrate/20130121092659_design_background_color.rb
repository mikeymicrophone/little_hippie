class DesignBackgroundColor < ActiveRecord::Migration
  def up
    add_column :designs, :background_color, :string
  end

  def down
    remove_column :designs, :background_color
  end
end
