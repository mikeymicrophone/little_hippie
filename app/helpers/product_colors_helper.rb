module ProductColorsHelper
  def product_display_box product_color, coupon_id = nil
    div_for product_color.product, :class => 'stack' do
      like_heart_for(product_color.product) +
	    (product_color.product.primary_image.present? ? link_to(image_tag(product_color.product.primary_image(:product_box), :style => "background-color:##{product_color.color.css_hex_code}"), detail_product_path(product_color.product, :coupon_id => coupon_id)) : '') +
	    div_for(product_color.product, :gray_label_for, :class => 'gray_label') do
	      link_to detail_product_path(product_color.product, :coupon_id => coupon_id) do
  	      (product_color.product.design.name + '<br>' + product_color.product.body_style.name).html_safe
  	    end
	    end
	  end
  end
  
  def color_display_box product_color
    color = product_color.color
    div_for product_color.product, :class => 'stack' do
      like_heart_for(product_color.product) +
	    (product_color.product.primary_image.present? ? link_to(image_tag(product_color.product.primary_image(:product_box), :style => "background-color:##{product_color.color.css_hex_code}"), detail_color_path(product_color.color)) : '') +
	    div_for(product_color.product, :gray_label_for, :class => 'gray_label') do
	      link_to detail_color_path(color) do
  	      (color.name.capitalize + '<br>' + pluralize(color.product_colors.active_product.count, 'product')).html_safe
  	    end
	    end
	  end
  end
end
