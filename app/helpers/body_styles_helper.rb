module BodyStylesHelper
  def filtered_navigation_system
    content_tag :nav, :id => 'filtered_navigation' do
      Category.age_group.map do |age|
        filter_option age
      end.join.html_safe
    end
  end
  
  def filter_option criterion
    content_tag :div, :class => 'filter_criterion' do
      label_tag(dom_id(criterion), criterion.name) +
      check_box_tag(dom_id(criterion), dom_id(criterion), nil, :class => 'filter')
    end    
  end
end
