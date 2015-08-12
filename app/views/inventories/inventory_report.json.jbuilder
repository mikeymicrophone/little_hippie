json.inventory do
  json.skus @inventory_totals do |sku|
    json.sku sku[:sku]
    json.qty sku[:qty]
  end
end
