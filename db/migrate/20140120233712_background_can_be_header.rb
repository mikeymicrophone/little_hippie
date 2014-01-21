class BackgroundCanBeHeader < ActiveRecord::Migration
  def up
    add_column :backgrounds, :header, :boolean
  end

  def down
    remove_column :backgrounds, :header
  end
end
