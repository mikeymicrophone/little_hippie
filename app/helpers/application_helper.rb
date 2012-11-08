module ApplicationHelper
  def login_links
    if current_business_manager
      link_to 'log out (Business Manager)', business_manager_logout_path, :class => 'account'
    else
      link_to 'log in as Business Manager', business_manager_login_path, :class => 'account'
    end + ' ' +
    if current_product_manager
      link_to 'log out (Product Manager)', product_manager_logout_path, :class => 'account'
    else
      link_to 'log in as Product Manager', product_manager_login_path, :class => 'account'
    end
  end
  
  def link_to_name obj
    if obj
      link_to obj.name, obj if obj.respond_to?(:name)
    else
      
    end
  end
  
  def clearboth
    content_tag(:div, :class => 'clearboth') {}
  end
end
