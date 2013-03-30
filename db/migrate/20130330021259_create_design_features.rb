class CreateDesignFeatures < ActiveRecord::Migration
  def change
    create_table :design_features do |t|
      t.belongs_to :design
      t.integer :position
      t.datetime :active_from
      t.datetime :active_until
      t.integer :business_manager_id

      t.timestamps
    end
    add_index :design_features, :design_id
  end
end
