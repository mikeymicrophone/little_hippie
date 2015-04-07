class InventorySnapshot < ActiveRecord::Base
  belongs_to :garment
  has_one :color, :through => :garment
  has_one :size, :through => :garment
  has_one :design, :through => :garment
  has_one :body_style, :through => :garment
  has_many :received_inventories, :foreign_key => :first_snapshot_id, :dependent => :nullify
  attr_accessible :current_amount, :initial_amount, :garment, :garment_id, :current
  
  scope :of_color, lambda { |color_id| joins(:color).where('colors.id' => color_id) }
  scope :of_body_style, lambda { |body_style_id| joins(:body_style).where('body_styles.id' => body_style_id) }
  scope :of_design, lambda { |design_id| joins(:design).where('designs.id' => design_id) }
  scope :of_size, lambda { |size_id| joins(:size).where('sizes.id' => size_id) }
  scope :currently_in_stock, lambda { current.in_stock }
  scope :current, where(:current => true)
  scope :in_stock, where('current_amount > 0')
  scope :outdated, where(:current => false)
  scope :ordered, joins(:body_style, :design, :size, :color).order('designs.number', 'body_styles.position', 'sizes.position', 'colors.position')
  scope :sized, joins(:size).order('sizes.position')
  
  delegate :product_color, :to => :garment
  delegate :og_code, :to => :product_color, :allow_nil => true
  
  def amount
    "#{current_amount}/#{initial_amount}"
  end
  
  def is_not_current!
    update_attribute :current, false
  end
  
  def previous_snapshots
    garment.inventory_snapshots.order('created_at desc').andand.-(self)
  end
  
  def self.find_by_og_code og_code
    product_color = ProductColor.find_by_og_code og_code
    product_color.inventory_snapshots
  end
  
  def self.create_csv file_name
    products_by_color = ProductColor.inventory_order
    CSV.open(file_name, 'wb', :headers => true) do |csv|
      csv << ['Product', 'Color', *Size.ordered.map(&:name)]
      products_by_color.each do |pc|
        inventory_snapshots = pc.inventory_snapshots.current.of_color(pc.color_id).sized
        csv << [pc.product.name, pc.color.name, *Size.ordered.map { |s| inventory_snapshots.select { |i| i.size == s }.first.andand.current_amount }]
      end
    end
  end
end
