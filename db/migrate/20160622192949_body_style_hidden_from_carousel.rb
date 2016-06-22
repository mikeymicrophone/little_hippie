class BodyStyleHiddenFromCarousel < ActiveRecord::Migration
  def up
    add_column :body_styles, :hidden_from_carousel, :boolean
  end

  def down
    remove_column :body_styles, :hidden_from_carousel
  end
end
