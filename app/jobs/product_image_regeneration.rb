class ProductImageRegeneration
  def perform design_id
    Design.find(design_id).regenerate_all_product_images
  end
  
  def queue
    :mailer
  end
end
