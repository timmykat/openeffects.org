class Company < ActiveRecord::Base
  has_one :contact, class_name: "User"
  validates :name, :presence => true
end
