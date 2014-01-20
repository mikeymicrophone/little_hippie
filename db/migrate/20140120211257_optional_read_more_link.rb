class OptionalReadMoreLink < ActiveRecord::Migration
  def up
    add_column :bulletins, :show_more, :boolean
  end

  def down
    remove_column :bulletins, :show_more
  end
end
