class BulletinHasTeaser < ActiveRecord::Migration
  def up
    add_column :bulletins, :teaser, :text
  end

  def down
    remove_column :bulletins, :teaser
  end
end
