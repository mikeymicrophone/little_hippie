json.inventory do
  json.skus @inventory_totals do |sku|
    json.sku sku[:sku]
    json.size sku[:size]
    json.amount sku[:amount]
  end
end
