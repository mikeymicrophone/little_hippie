class BannerTagOrder < ActiveRecord::Migration
  def up
    add_column :banner_tags, :position, :integer
    
    BannerTag.all.each { |banner_tag| banner_tag.insert_at(1) }
  end

  def down
    remove_column :banner_tags, :position
  end
end
