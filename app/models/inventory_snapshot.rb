class InventorySnapshot < ActiveRecord::Base
  belongs_to :garment
  has_one :color, :through => :garment
  has_one :size, :through => :garment
  has_one :design, :through => :garment
  has_one :body_style, :through => :garment
  has_many :received_inventories, :foreign_key => :first_snapshot_id, :dependent => :nullify
  attr_accessible :current_amount, :initial_amount, :garment, :garment_id, :current
  
  scope :of_color, lambda { |color_id| joins(:color).where('colors.id' => color_id) }
  scope :current, where(:current => true)
  scope :ordered, joins(:body_style, :design, :size, :color).order('designs.number', 'body_styles.position', 'sizes.position', 'colors.position')
  scope :sized, joins(:size).order('sizes.position')
  
  delegate :product_color, :to => :garment
  
  def amount
    "#{current_amount}/#{initial_amount}"
  end
  
  def previous_snapshots
    garment.inventory_snapshots.order('created_at desc').andand.-(self)
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
