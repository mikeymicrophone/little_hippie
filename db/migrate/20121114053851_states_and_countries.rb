class StatesAndCountries < ActiveRecord::Migration
  def up
    create_table :countries do |t|
      t.string :iso
      t.string :name
    end

    create_table :states do |t|
      t.string :name
      t.integer :country_id
      t.string :iso
    end

  end

  def down
    drop_table :countries
    drop_table :states
  end
end
