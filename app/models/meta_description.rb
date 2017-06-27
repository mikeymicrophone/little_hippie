class MetaDescription < ActiveRecord::Base
  attr_accessible :action, :controller, :current, :description, :keywords, :og_image, :resource_id, :url
  attr_accessor :url
  before_create :identify_category
  
  def self.parse_url url
    Rails.application.routes.recognize_path url
  end
  
  def identify_category
    if controller == 'categories' && action == 'show'
      self.resource_id = Category.find_by(:slug => url.split('/').last).id
    end
  end
end
