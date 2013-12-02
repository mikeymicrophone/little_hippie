class BulletinsStoreFacebookUrlAndOgType < ActiveRecord::Migration
  def up
    add_column :bulletins, :og_type, :string
    add_column :bulletins, :og_url, :text
  end

  def down
    remove_column :bulletins, :og_type
    remove_column :bulletins, :og_url
  end
end
