class InventoryList < ActiveRecord::Base
  attr_accessible :xml_file
  mount_uploader :xml_file, XmlFileUploader
end
