class GarmentHasMwwCode < ActiveRecord::Migration
  def up
    add_column :garments, :mww_code, :string
  end

  def down
    remove_column :garments, :mww_code
  end
end
