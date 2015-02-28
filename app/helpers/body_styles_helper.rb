module BodyStylesHelper
  def filtered_navigation_system
    content_tag :nav, :id => 'filtered_navigation' do
      Category.age_group.map do |age|
        content_tag :div, :class => 'age_group' do
          check_box_tag(dom_id(age), dom_id(age), nil, :class => 'filter') +
          label_tag(dom_id(age), age.name)
        end
      end.join.html_safe
    end
  end
end
