class CreateBulletinPairings < ActiveRecord::Migration
  def change
    create_table :bulletin_pairings do |t|
      t.belongs_to :bulletin
      t.belongs_to :content_page
      t.integer :position

      t.timestamps
    end
    add_index :bulletin_pairings, :bulletin_id
    add_index :bulletin_pairings, :content_page_id
  end
end
