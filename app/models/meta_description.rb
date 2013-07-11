class MetaDescription < ActiveRecord::Base
  attr_accessible :action, :controller, :current, :description, :keywords, :og_image, :resource_id
  attr_accessor :url
  
  def self.parse_url url
    Rails.application.routes.recognize_path url
  end
end
