class SaleInclusion < ActiveRecord::Base
  belongs_to :sale
  belongs_to :inclusion, :polymorphic => true
  attr_accessible :sale_id, :active, :begin_date, :end_date, :inclusion_id, :inclusion_type
    
  scope :active, lambda { where :active => true }
  scope :current, lambda { where('(sale_inclusions.begin_date is null or sale_inclusions.begin_date < ?) and (sale_inclusions.end_date is null or sale_inclusions.end_date > ?)', Time.now, Time.now) }
  scope :applicable, lambda { active.current.includes(:sale).merge(Sale.active).merge(Sale.current) }

  def products
    case inclusion_type
    when 'Design', 'BodyStyle'
      inclusion.products
    when 'Product'
      [inclusion]
    else
      []
    end
  end
  
  def product_colors
    case inclusion_type
    when Color
      inclusion.product_colors
    when ProductColor
      [inclusion]
    when Garment
      [inclusion.product_color]
    else
      products.map(&:product_colors).flatten.uniq
    end
  end
end
