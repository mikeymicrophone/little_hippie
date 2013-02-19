namespace :image_buckets do
  task :copy_designs => :environment do
    CarrierWave.configure do |c|
      c.fog_directory = 'little_hippie' # production
    end
    
    image_storage = {}
    
    # reliance on local data matching production data
    Design.all.each do |design|
      puts 'storing art'
      image_storage[design.id] = design.art
    end
    
    CarrierWave.configure do |c|
      c.fog_directory = 'little-hippie-development' # staging
    end
    
    image_storage.each do |k, v|
      design = Design.find(k)
      design.art = v
      puts 'saving art'
      design.save
    end
  end
  
  task :copy_body_styles => :environment do
    CarrierWave.configure do |c|
      c.fog_directory = 'little_hippie' # production
    end
    
    image_storage = {}
    
    # reliance on local data matching production data
    BodyStyle.all.each do |body|
      puts 'storing body style'
      image_storage[body.id] = body.image
    end
    
    CarrierWave.configure do |c|
      c.fog_directory = 'little-hippie-development' # staging
    end
    
    image_storage.each do |k, v|
      body = BodyStyle.find(k)
      body.image = v
      puts 'saving body style'
      body.save
    end    
  end
end
