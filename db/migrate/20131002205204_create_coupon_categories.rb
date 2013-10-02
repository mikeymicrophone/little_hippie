class CreateCouponCategories < ActiveRecord::Migration
  def change
    create_table :coupon_categories do |t|
      t.belongs_to :coupon
      t.belongs_to :category

      t.timestamps
    end
    add_index :coupon_categories, :coupon_id
    add_index :coupon_categories, :category_id
  end
end
