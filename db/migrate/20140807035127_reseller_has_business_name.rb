class ResellerHasBusinessName < ActiveRecord::Migration
  def up
    add_column :resellers, :business_name, :string
  end

  def down
    remove_column :resellers, :business_name
  end
end
