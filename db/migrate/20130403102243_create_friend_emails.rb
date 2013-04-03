class CreateFriendEmails < ActiveRecord::Migration
  def change
    create_table :friend_emails do |t|
      t.text :message
      t.belongs_to :product
      t.belongs_to :color
      t.belongs_to :size
      t.belongs_to :customer
      t.text :email

      t.timestamps
    end
    add_index :friend_emails, :product_id
    add_index :friend_emails, :color_id
    add_index :friend_emails, :size_id
    add_index :friend_emails, :customer_id
  end
end
