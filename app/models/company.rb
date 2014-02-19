class Company < ActiveRecord::Base
  has_one :contact, class_name: "User", :foreign_key => :contact_id
  validates :name, :presence => true
end
