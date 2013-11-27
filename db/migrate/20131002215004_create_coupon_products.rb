class CreateCouponProducts < ActiveRecord::Migration
  def change
    create_table :coupon_products do |t|
      t.belongs_to :coupon
      t.belongs_to :product

      t.timestamps
    end
    add_index :coupon_products, :coupon_id
    add_index :coupon_products, :product_id
  end
end
