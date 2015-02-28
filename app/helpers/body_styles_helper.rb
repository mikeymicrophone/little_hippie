module BodyStylesHelper
  def filtered_navigation_system
    content_tag :nav, :id => 'filtered_navigation' do
      Category.age_group.map do |age|
        content_tag :div, :class => 'age_group' do
          check_box_tag(age) +
          age.name
        end
      end.join.html_safe
    end
  end
end
