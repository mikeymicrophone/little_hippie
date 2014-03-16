class ProductImageRegeneration
  def self.perform design_id
    puts "about to regenerate product images for #{Design.find(design_id).name}"
    Design.find(design_id).regenerate_all_product_images
    puts "finished regenerating images for #{Design.find(design_id).name}"
  end
  
  def self.queue
    :mailer
  end
end
