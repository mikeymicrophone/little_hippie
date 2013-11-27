class ProductHasOpenGraphId < ActiveRecord::Migration
  def up
    add_column :products, :open_graph_id, :string
  end

  def down
    remove_column :products, :open_graph_id
  end
end
