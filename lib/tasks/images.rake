namespace :images do
  task :copy_designs => :environment do
    CarrierWave.configure do |c|
      c.fog_directory = 'little_hippie' # production
    end
    
    image_storage = {}
    
    # reliance on local data matching production data
    Design.all.each do |design|
      image_storage[design.id] = design.art
    end
    
    CarrierWave.configure do |c|
      c.fog_directory = 'little-hippie-staging' # staging
    end
    
    image_storage.each do |k, v|
      design = Design.find(k)
      design.art = v
      design.save
    end
  end
  
  task :copy_body_styles => :environment do
    
  end
end
