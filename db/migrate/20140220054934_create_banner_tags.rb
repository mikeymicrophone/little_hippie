class CreateBannerTags < ActiveRecord::Migration
  def change
    create_table :banner_tags do |t|
      t.belongs_to :banner
      t.string :tag_type
      t.integer :tag_id
      t.boolean :active, :default => true

      t.timestamps
    end
    add_index :banner_tags, :banner_id
  end
end
