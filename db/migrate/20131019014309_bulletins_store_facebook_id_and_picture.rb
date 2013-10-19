class BulletinsStoreFacebookIdAndPicture < ActiveRecord::Migration
  def up
    add_column :bulletins, :facebook_post_id, :string
    add_column :bulletins, :facebook_image_url, :string
  end

  def down
    remove_column :bulletins, :facebook_post_id
    remove_column :bulletins, :facebook_image_url
  end
end
