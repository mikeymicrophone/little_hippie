class CustomerHasFacebookId < ActiveRecord::Migration
  def up
    add_column :customers, :facebook_id, :string
  end

  def down
    remove_column :customers, :facebook_id
  end
end
