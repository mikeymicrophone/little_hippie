class ResellerDetails < ActiveRecord::Migration
  def up
    add_column :resellers, :tax_id, :string
    add_column :resellers, :current_discount_percentage, :float
    add_column :resellers, :note, :text
  end

  def down
    remove_column :resellers, :tax_id
    remove_column :resellers, :current_discount_percentage
    remove_column :resellers, :note
  end
end
