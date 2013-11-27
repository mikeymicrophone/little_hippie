class LikesHaveFacebookData < ActiveRecord::Migration
  def up
    add_column :likes, :facebook_user_id, :string
    add_column :likes, :facebook_user_name, :string
  end

  def down
    remove_column :likes, :facebook_user_id
    remove_column :likes, :facebook_user_name
  end
end
