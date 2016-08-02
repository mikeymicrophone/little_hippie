module ProductColorsHelper
  def product_display_box product_color, size = :product_box
    div_for product_color.product, :class => "stack product_color_#{product_color.id}", :'data-product_id' => product_color.product_id, :'data-product_color_id' => product_color.id do
      like_heart_for(product_color.product) +
	    (product_color.product.primary_image.present? ? link_to(colored_image(product_color, size), detail_product_path(product_color.product)) : '') +
	    div_for(product_color.product, :gray_label_for, :class => 'gray_label') do
        div_for(product_color.product, :price_label_for, :class => 'price_label') do
          "<span class='dollar_sign'>$</span>".html_safe +
          "#{product_color.product.sale_price.to_i}"
        end +
	      link_to(detail_product_path(product_color.product)) do
          if product_color.product.name_override.present?
            product_color.product.name
          else
    	      (product_color.product.design.name + '<br>' + product_color.product.body_style.name).html_safe
          end
  	    end
	    end
	  end
  end
  
  def color_display_box product_color, size = :product_box
    color = product_color.color
    div_for product_color.product, :class => "stack product_color_#{product_color.id}", :'data-product_id' => product_color.product_id, :'data-color_id' => color.id do
      like_heart_for(product_color.product) +
	    (product_color.product.primary_image.present? ? link_to(colored_image(product_color, size), detail_color_path(product_color.color)) : '') +
	    div_for(product_color.product, :gray_label_for, :class => 'gray_label') do
	      link_to detail_color_path(color) do
  	      (color.name.capitalize + '<br>' + pluralize(color.product_colors.active_product.available.count, 'product')).html_safe
  	    end
	    end
	  end.html_safe
  end
  
  def colored_image product_color, size = :product_box
    if product_color.product_images.present?
      image = product_color.product_images.last.image
    else
      image = product_color.product.primary_image(size)
    end
    image_tag(image, :style => "background-color:##{product_color.color.css_hex_code}")
  end
end
