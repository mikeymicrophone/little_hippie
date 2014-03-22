class BulletinStoresBannerId < ActiveRecord::Migration
  def up
    add_column :bulletins, :banner_id, :integer
  end

  def down
    remove_column :bulletins, :banner_id
  end
end
