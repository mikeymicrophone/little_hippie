class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.string :name
      t.text :note
      t.datetime :approved_at
      t.string :invited_by_email
      t.string :invited_by_name

      t.timestamps
    end
  end
end
