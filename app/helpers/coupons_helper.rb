module CouponsHelper
  def incentive_coupon
    Coupon.find_by_code YAML::load(File.open(File.join(Rails.root, 'config', 'incentive_coupon.yml'))).andand['coupon_code'] rescue nil
  end
end
