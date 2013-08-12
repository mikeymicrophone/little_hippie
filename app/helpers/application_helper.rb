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
      link_to obj.name, obj, opts if obj.respond_to?(:name)
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
  
  def clearboth
    content_tag(:div, :class => 'clearboth') {}
  end
  
  def detail_banner_url banner
    display_banner_url banner
  end
end
