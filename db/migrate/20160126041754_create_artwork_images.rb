class CreateArtworkImages < ActiveRecord::Migration
  def change
    create_table :artwork_images do |t|
      t.belongs_to :garment
      t.string :fabric_photo
      t.string :name
      t.boolean :active

      t.timestamps
    end
    add_index :artwork_images, :garment_id
  end
end
