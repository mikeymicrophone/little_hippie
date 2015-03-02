module BodyStylesHelper
  def filtered_navigation_system
    content_tag :nav, :id => 'filtered_navigation' do
      Category.age_group.map do |age|
        filter_option age
      end.join.html_safe +
      Color.ordered.map do |color|
        color_filter_option color
      end.join.html_safe
    end
  end
  
  def filter_option criterion
    content_tag :div, :class => 'filter_criterion' do
      label_tag(dom_id(criterion), criterion.name) +
      check_box_tag(dom_id(criterion), dom_id(criterion), nil, :class => 'filter')
    end
  end
  
  def size_filter_option criterion
    content_tag :div, :class => 'filter_criterion size_filter' do
      label_tag(dom_id(criterion), criterion.letter_code) +
      check_box_tag(dom_id(criterion), dom_id(criterion), nil, :class => 'filter')
    end
  end
  
  def color_filter_option criterion
    content_tag :div, :id => dom_id(criterion, :filter_ribbon_for), :class => 'filter_criterion color_filter', :style => "background-color:##{criterion.css_hex_code}" do
      label_tag(dom_id(criterion), criterion.name) +
      check_box_tag(dom_id(criterion), dom_id(criterion), nil, :class => 'filter')
    end
  end
end
