module BannersHelper
  def last_tagged_product_for banner
    return nil unless banner.banner_tags.present?
    tags = banner.banner_tags.map(&:tag_type)
    if tags.include?('Product')
      tag = banner.banner_tags.where(:tag_type => 'Product').last
      detail_product_path(tag.tag_id)
    elsif tags.include?('Design')
      tag = banner.banner_tags.where(:tag_type => 'Design').last
      detail_design_path(tag.tag_id)
    elsif tags.include?('BodyStyle')
      tag = banner.banner_tags.where(:tag_type => 'BodyStyle').last
      detail_body_style_path(tag.tag_id)
    else
      tag = banner.banner_tags.last.tag
      case tag
      when Color
        detail_color_path(tag)
      when Garment
        detail_product_path(tag.product)
      when ProductColor
        detail_product_path(tag.product)
      when Size
        root_url
      end
    end
  end
end
