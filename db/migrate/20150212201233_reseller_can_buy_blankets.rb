class ResellerCanBuyBlankets < ActiveRecord::Migration
  def up
    add_column :resellers, :can_buy_blankets, :boolean
  end

  def down
    remove_column :resellers, :can_buy_blankets
  end
end
