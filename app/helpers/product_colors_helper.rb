module ProductColorsHelper
  def product_display_box product_color
    div_for product_color.product, :class => "stack product_color_#{product_color.id}", :'data-product_id' => product_color.product_id, :'data-product_color_id' => product_color.id do
      like_heart_for(product_color.product) +
	    (product_color.product.primary_image.present? ? link_to(colored_image(product_color), detail_product_path(product_color.product)) : '') +
	    div_for(product_color.product, :gray_label_for, :class => 'gray_label') do
        div_for(product_color.product, :price_label_for, :class => 'price_label') do
          "<span class='dollar_sign'>$</span>".html_safe +
          "#{product_color.product.sale_price.to_i}"
        end +
	      link_to(detail_product_path(product_color.product)) do
  	      (product_color.product.design.name + '<br>' + product_color.product.body_style.name).html_safe
  	    end
	    end
	  end
  end
  
  def color_display_box product_color
    color = product_color.color
    div_for product_color.product, :class => "stack product_color_#{product_color.id}", :'data-product_id' => product_color.product_id, :'data-color_id' => color.id do
      like_heart_for(product_color.product) +
	    (product_color.product.primary_image.present? ? link_to(image_tag(colored_image(product_color)), detail_color_path(product_color.color)) : '') +
	    div_for(product_color.product, :gray_label_for, :class => 'gray_label') do
	      link_to detail_color_path(color) do
  	      (color.name.capitalize + '<br>' + pluralize(color.product_colors.active_product.count, 'product')).html_safe
  	    end
	    end
	  end
  end
  
  def colored_image product_color
    image_tag(product_color.product.primary_image(:product_box), :style => "background-color:##{product_color.color.css_hex_code}")
  end
end
