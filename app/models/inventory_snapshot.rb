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
end
