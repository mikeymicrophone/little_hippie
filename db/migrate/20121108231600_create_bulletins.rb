class CreateBulletins < ActiveRecord::Migration
  def change
    create_table :bulletins do |t|
      t.string :title
      t.text :content
      t.boolean :active

      t.timestamps
    end
  end
end
