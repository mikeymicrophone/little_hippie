module ApplicationHelper
  def login_links
    if current_business_manager
      link_to 'log out', logout_path
    else
      link_to 'log in', login_path
    end
  end
end
