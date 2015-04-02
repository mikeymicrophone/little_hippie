module BodyStylesHelper
  def filtered_navigation_system
    content_tag :nav, :id => 'filtered_navigation' do
      "<div class='filter_instructions'>Refine Your Age Group</div>".html_safe +
      Category.age_group.map do |age|
        filter_option age
      end.join.html_safe +
      "<div class='filter_instructions'>Pick Colors</div>".html_safe +
      Color.ordered.featured.available.uniq.map do |color|
        color_filter_option color
      end.join.html_safe
    end
  end
  
  def filter_option criterion
    content_tag :div, :class => 'filter_criterion' do
      check_box_tag(dom_id(criterion), dom_id(criterion), nil, :class => 'filter') +
      label_tag(dom_id(criterion), criterion.name)
    end
  end
  
  def size_filter_option criterion
    content_tag :div, :class => 'filter_criterion size_filter' do
      label_tag(dom_id(criterion), criterion.letter_code) +
      check_box_tag(dom_id(criterion), dom_id(criterion), nil, :class => 'filter')
    end
  end
  
  def color_filter_option criterion
    content_tag :label, :id => dom_id(criterion, :filter_ribbon_for), :for => dom_id(criterion), :class => 'filter_criterion color_filter', :style => "background-color:##{criterion.css_hex_code}" do
      check_box_tag(dom_id(criterion), dom_id(criterion), nil, :class => 'filter')
    end
  end
end
