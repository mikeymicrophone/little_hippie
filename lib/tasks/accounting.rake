namespace :accounting do
  desc 'products copy cost from their body style'
  task :price_products => :environment do
    BodyStyle.all.each do |body_style|
      if body_style.cost.present?
        body_style.products.each do |product|
          if product.cost.blank?
            product.update_attribute :cost, body_style.cost
            puts "set cost of #{product.name} as #{product.cost / 100.0}"
          end
        end
      end
    end
  end
end
