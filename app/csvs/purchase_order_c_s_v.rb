class PurchaseOrderCSV
  def initialize wishlist
    @wishlist = wishlist
  end

  def write_csv filename
    CSV.open(File.join(Rails.root, "tmp", filename), "wb") do |csv|
      csv << [
        "Code",
        "Item",
        "Color",
        "Size",
        "Design"
      ]
      list_wishlist_items csv
    end
  end

  def list_wishlist_items csv
    @wishlist.wishlist_items.body_style_order.each { |wishlist_item| specifications_for wishlist_item, csv }
  end

  def specifications_for wishlist_item, csv
    csv << [
      '',
      wishlist_item.body_style.name,
      wishlist_item.color.name,
      wishlist_item.size.name,
      wishlist_item.design.name
    ]
  end
end
