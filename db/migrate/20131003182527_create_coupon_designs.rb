class CreateCouponDesigns < ActiveRecord::Migration
  def change
    create_table :coupon_designs do |t|
      t.belongs_to :coupon
      t.belongs_to :design

      t.timestamps
    end
    add_index :coupon_designs, :coupon_id
    add_index :coupon_designs, :design_id
  end
end
