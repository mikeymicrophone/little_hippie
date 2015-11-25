module ApplicationHelper
  def login_links
    if current_business_manager
      link_to 'log out (Business Manager)', business_manager_logout_path, :class => 'btn account'
    else
      link_to 'log in as Business Manager', business_manager_login_path, :class => 'btn account'
    end + ' ' +
    if current_product_manager
      link_to 'log out (Product Manager)', product_manager_logout_path, :class => 'btn account'
    else
      link_to 'log in as Product Manager', product_manager_login_path, :class => 'btn account'
    end
  end
  
  def link_to_name obj, opts = {}
    if obj
      link_to(obj.name, obj, opts) if obj.respond_to?(:name)
    else
      
    end
  end
  
  def google_analytics
    script = <<-GOOGLE_ANALYTICS
      <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', '#{ENV['GOOGLE_ANALYTICS_CODE']}', '#{request.host}');
        ga('send', 'pageview');

      </script>
    GOOGLE_ANALYTICS
    script.html_safe
  end
  
  def facebook_pixel
    script = <<-FACEBOOK_PIXEL
      <!-- Facebook Pixel Code -->
      <script>
      !function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
      n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
      n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
      t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
      document,'script','//connect.facebook.net/en_US/fbevents.js');

      fbq('init', '#{ENV['FACEBOOK_PIXEL_CODE']}');
      fbq('track', "PageView");</script>
      <noscript><img height="1" width="1" style="display:none"
      src="https://www.facebook.com/tr?id=#{ENV['FACEBOOK_PIXEL_CODE']}&ev=PageView&noscript=1"
      /></noscript>
      <!-- End Facebook Pixel Code -->
    FACEBOOK_PIXEL
    script.html_safe
  end
  
  def clearboth
    content_tag(:div, :class => 'clearboth') {}
  end
  
  def detail_banner_url banner
    display_banner_url banner
  end
  
  def top_level_browser
    # content_tag(:div, :id => "shop_by_color_title") do
    #   link_to('Browse by Color', browse_colors_path)
    # end +
    # content_tag(:div, :id => "shop_by_color") do
    # end +
    content_tag(:div, :id => "shop_by_style_title") do
      link_to('Browse by Style', browse_body_styles_path) +
      link_to('&raquo;'.html_safe, '', :id => "right_related_products_control", :class => 'right') + 
      link_to('&laquo;&nbsp;&nbsp;'.html_safe, '', :id => "left_related_products_control", :class => 'right')
    end +
    content_tag(:div, :id => "shop_by_style", :class => "similar_products jcarousel", :'data-number-of-products' => BodyStyle.active.with_image.count) do
      content_tag(:ul) do
        BodyStyle.active.with_image.map do |body_style|
          content_tag(:li, :class => 'similar_item') do
            link_to detail_body_style_path(body_style) do
              div_for(body_style, :class => 'body_style_list similar_item') do
                image_tag(body_style.image.url(:product_box))
              end
            end
          end
        end.join.html_safe
      end
    end +
    content_tag(:div, :id => "shop_by_design_title") do
      link_to('Browse by Design', browse_designs_path)
    end +
    content_tag(:div, :id => "shop_by_design", :class => "similar_products jcarousel", :'data-number-of-products' => Design.featured.count) do
      content_tag(:ul) do
        Design.featured.map do |design|
          content_tag(:li, :class => 'similar_item') do
            link_to detail_design_path(design) do
              image_tag(design.art.url(:enlargement))
            end
          end
        end.join.html_safe
      end
    end +
    content_tag(:div, :id => "browse_sale_items_title") do
     link_to('Sale Items', browse_sales_path)
    end +
    content_tag(:div, :id => "browse_sale_items", :class => "similar_products jcarousel", :'data-number-of-products' => 30) do
      content_tag(:ul) do
        Sale.current.map(&:sale_inclusions).flatten.map(&:product_colors).flatten.select(&:active?).uniq.sort_by{rand}[0..29].map do |product_color|
          content_tag(:li, :class => 'similar_item') do
            product_display_box product_color
          end
        end.join.html_safe
      end
    end.html_safe
  end
end
