module LikesHelper
  def like_heart_for favorite
    favorite_type = favorite.class.name
    favorite_name = favorite_type.underscore
    if send("liked_#{favorite_name}s").include?(favorite.id)
      image_tag(asset_path('purple_heart.png'), :class => 'heart')
    else
      link_to(image_tag(asset_path('maroon_heart.png'), :title => "Like this #{favorite_type}", :class => 'heart', :id => dom_id(favorite, :heart_for)), likes_path(:like => {:favorite_id => favorite.id, :favorite_type => favorite_type}), "data-#{favorite_name}_url" => send("detail_#{favorite_name}_url", favorite), :remote => true, :method => :post, :class => "#{favorite_name}_like")
    end +
    "<span class='like_count #{favorite_name}_like' id='#{dom_id favorite, :likes_of}'>#{favorite.likes.count}</span>".html_safe
  end
end
