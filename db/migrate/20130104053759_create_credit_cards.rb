class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.belongs_to :customer
      t.string :stripe_customer_id
      t.string :status
      t.integer :position

      t.timestamps
    end
    add_index :credit_cards, :customer_id
  end
end
