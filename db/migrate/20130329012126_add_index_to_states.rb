class AddIndexToStates < ActiveRecord::Migration
  def change
    add_index :states, :country_id
    add_index :states, :name
  end
end
