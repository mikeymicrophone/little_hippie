module BannerTagsHelper
  def tagged_banners_path tag
    case tag
    when Design
      design_banner_tags_path tag
    when BodyStyle
      body_style_banner_tags_path tag
    when Color
      color_banner_tags_path tag
    when Size
      size_banner_tags_path tag
    when Product
      product_banner_tags_path tag
    when ProductColor
      product_color_banner_tags_path tag
    when Garment
      garment_banner_tags_path tag
    end
  end
end
