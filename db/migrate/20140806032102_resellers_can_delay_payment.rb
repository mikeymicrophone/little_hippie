class ResellersCanDelayPayment < ActiveRecord::Migration
  def up
    add_column :resellers, :delay_payment, :boolean, :default => false
  end

  def down
    remove_column :resellers, :delay_payment
  end
end
