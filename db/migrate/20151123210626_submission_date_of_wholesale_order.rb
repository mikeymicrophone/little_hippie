class SubmissionDateOfWholesaleOrder < ActiveRecord::Migration
  def up
    add_column :wholesale_orders, :submission_date, :datetime
    
    WholesaleOrder.submitted.each { |wholesale_order| wholesale_order.update_column :submission_date, wholesale_order.updated_at }
  end

  def down
    remove_column :wholesale_orders, :submission_date
  end
end
