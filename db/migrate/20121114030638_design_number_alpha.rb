class DesignNumberAlpha < ActiveRecord::Migration
  def up
    change_column :designs, :number, :string
  end

  def down
    change_column :designs, :number, :integer
  end
end
