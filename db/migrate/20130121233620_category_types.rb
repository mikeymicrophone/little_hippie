class CategoryTypes < ActiveRecord::Migration
  def up
    add_column :categories, :is_age_group, :boolean
    add_column :categories, :is_cut_type, :boolean
  end

  def down
    remove_column :categories, :is_age_group
    remove_column :categories, :is_cut_type
  end
end
