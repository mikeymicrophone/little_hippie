class ShareCounters < ActiveRecord::Migration
  def up
    add_column :products, :target_share_count, :integer
    add_column :products, :target_post_id, :string
  end

  def down
    remove_column :products, :target_share_count
    remove_column :products, :target_post_id
  end
end
