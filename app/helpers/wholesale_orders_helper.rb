module WholesaleOrdersHelper
  def wholesale_cart_sort_row
    content_tag :tr do
      content_tag(:th) { link_to 'Quantity', sort_cart_wholesale_orders_path(:sort => 'quantity'), :remote => true } +
      content_tag(:th) { 'Image' } +
      content_tag(:th) { link_to 'Product Name', sort_cart_wholesale_orders_path(:sort => 'name'), :remote => true } +
      content_tag(:th) { link_to 'Style', sort_cart_wholesale_orders_path(:sort => 'body_style'), :remote => true } +
      content_tag(:th) { link_to 'Design', sort_cart_wholesale_orders_path(:sort => 'design'), :remote => true } +
      content_tag(:th) { link_to 'Color', sort_cart_wholesale_orders_path(:sort => 'color'), :remote => true } +
      content_tag(:th) { link_to 'Size', sort_cart_wholesale_orders_path(:sort => 'size'), :remote => true } +
      content_tag(:th) { link_to 'Unit Price', sort_cart_wholesale_orders_path(:sort => 'unit price'), :remote => true } +
      content_tag(:th) { link_to 'Line Total', sort_cart_wholesale_orders_path(:sort => 'line total'), :remote => true }
    end
  end
  
  def wholesale_cart_total_row wholesale_order
    content_tag :tr do
      content_tag(:th) +
      content_tag(:th) +
      content_tag(:th) +
      content_tag(:th) +
      content_tag(:th) +
      content_tag(:th) +
      content_tag(:th) +
      content_tag(:th) +
      content_tag(:th, :id => 'cart_total') { number_to_currency wholesale_order.dollar_price }      
    end
  end
  
  def wholesale_tab_nav
    content_tag :nav, :id => 'wholesale_order_form_tabs' do
      content_tag(:div, :id => 'body_styles_tab') do
        link_to 'Style', styles_wholesale_orders_path
      end +
      content_tag(:div, :id => 'designs_tab') do
        link_to 'Design', designs_wholesale_orders_path
      end +
      content_tag(:div, :id => 'cart_tab') do
        link_to 'Cart', cart_wholesale_orders_path
      end
    end    
  end
end
