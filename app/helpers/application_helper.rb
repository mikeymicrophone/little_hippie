module ApplicationHelper
  def login_links
    if current_business_manager
      link_to 'log out (Business Manager)', business_manager_logout_path
    else
      link_to 'log in as Business Manager', business_manager_login_path
    end + ' ' +
    if current_product_manager
      link_to 'log out (Product Manager)', product_manager_logout_path
    else
      link_to 'log in as Product Manager', product_manager_login_path
    end
  end
end
