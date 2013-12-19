module ProductsHelper
  def blanket_with_design design
    BodyStyle.find_by_code('RUG').products.with_design(design).first.andand.product_colors.andand.first
  end
end
