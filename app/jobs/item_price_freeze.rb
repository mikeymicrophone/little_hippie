class ItemPriceFreeze
  def self.queue
    :mailer
  end
  
  def self.perform cart_id
    Cart.find(cart_id).freeze_item_prices
  end
end
