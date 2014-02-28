namespace :image_buckets do
  namespace :copy do
    task :designs => :environment do
      CarrierWave.configure do |c|
        c.fog_directory = 'little-hippie' # bucket copied from
      end
    
      image_storage = {}
    
      # reliance on local data matching production data
      Design.all.each do |design|
        puts 'storing art'
        image_storage[design.id] = design.art
      end
    
      CarrierWave.configure do |c|
        c.fog_directory = 'little-hippie-staging' # bucket copied to
      end
    
      image_storage.each do |k, v|
        design = Design.find(k)
        design.art = v
        puts 'saving art'
        design.save
      end
    end
  
    task :body_styles => :environment do
      CarrierWave.configure do |c|
        c.fog_directory = 'little-hippie' # bucket copied from
      end
    
      image_storage = {}
    
      BodyStyle.all.each do |body|
        puts 'storing body style'
        image_storage[body.id] = body.image
      end
    
      CarrierWave.configure do |c|
        c.fog_directory = 'little-hippie-staging' # bucket copied to
      end
    
      image_storage.each do |k, v|
        body = BodyStyle.find(k)
        body.image = v
        puts 'saving body style'
        body.save
      end
    end    

    task :product_color_images => :environment do
      CarrierWave.configure do |c|
        c.fog_directory = 'little-hippie' # bucket copied from
      end
    
      image_storage = {}
    
      ProductImage.all.each do |image|
        puts 'storing product image'
        image_storage[image.id] = image.image
      end
    
      CarrierWave.configure do |c|
        # c.reset_config
        c.fog_directory = 'little-hippie-staging' # bucket copied to
      end
    
      image_storage.each do |k, v|
        image = ProductImage.find(k)
        image.image = v
        puts 'saving product image'
        image.save
      end
    end    

  end
end

namespace :product_image do
  desc "create a product_image for each product with the most recently used product_image_template"
  task :recreate_all => :environment do
    Product.all.each do |product|
      puts "Generating image for product #{product.id}, #{product.name}"
      product.generate_image_from_template product.product_images.last.andand.image_position_template
      puts product.product_images.last.andand.image_position_template.andand.display_name
    end
  end
  
  desc "delete unused product_images"
  task :remove_extras => :environment do
    Product.all.each do |product|
      primary_image = product.product_images.newest
      unneeded_images = product.product_images - primary_image
      if unneeded_images.length < product.product_images.length
        unneeded_images.each &:destroy
      end
    end
  end
end
