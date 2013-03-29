class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :message
      t.belongs_to :customer
      t.string :ip
      t.integer :read
      t.integer :starred
      t.integer :needs_reply
      t.integer :testimonial
      t.integer :refund

      t.timestamps
    end
    add_index :feedbacks, :customer_id
  end
end
