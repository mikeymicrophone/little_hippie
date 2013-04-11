class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :name
      t.string :subject
      t.text :message
      t.string :referer
      t.integer :read
      t.integer :flagged

      t.timestamps
    end
  end
end
