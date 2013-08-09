class LikePolymorphism < ActiveRecord::Migration
  def up
    add_column :likes, :favorite_type, :string
    add_column :likes, :favorite_id, :integer
    
    Like.all.each do |product_like|
      product_like.favorite_type = 'Product'
      product_like.favorite_id = product_like.product_id
      product_like.save :validate => false
    end
    
    remove_column :likes, :product_id
    
    remove_index :likes, :product_id
    add_index :likes, [:favorite_type, :favorite_id]
  end

  def down
    add_column :likes, :product_id, :integer
    
    Like.all.each do |like|
      if like.favorite_type == 'Product'
        like.product_id = like.favorite_id
        like.save
      end
    end
    
    remove_column :likes, :favorite_type
    remove_column :likes, :favorite_id
    
    remove_index :likes, [:favorite_type, :favorite_id]
    add_index :likes, :product_id
  end
end
