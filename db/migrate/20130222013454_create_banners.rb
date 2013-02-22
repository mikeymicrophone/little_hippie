class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
