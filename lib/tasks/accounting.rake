namespace :accounting do
  task :price_products => :environment do
    Bodystyle.all.each do |body_style|
      if body_style.cost.present?
        body_style.products.each do |product|
          if product.cost.blank?
            product.update_attribute :cost, body_style.cost
          end
        end
      end
    end
  end
end
