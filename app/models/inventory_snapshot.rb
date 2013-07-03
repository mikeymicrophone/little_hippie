class InventorySnapshot < ActiveRecord::Base
  belongs_to :garment
  has_one :color, :through => :garment
  has_one :size, :through => :garment
  has_one :design, :through => :garment
  has_one :body_style, :through => :garment
  has_many :received_inventories, :foreign_key => :first_snapshot_id, :dependent => :nullify
  attr_accessible :current_amount, :initial_amount, :garment, :garment_id, :current
  
  scope :current, where(:current => true)
  scope :ordered, includes(:body_style, :design, :size, :color).order('designs.number', 'body_styles.code', 'sizes.position', 'colors.position')
  
  delegate :product_color, :to => :garment
  
  def amount
    "#{current_amount}/#{initial_amount}"
  end
end
