class StandardChange < ActiveRecord::Base
  belongs_to :version
  
  validates :committee, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :type, inclusion: { in: Rails.configuration.ofx['standard_change_type'].keys, message: 'is not a valid change type' }
  validates :status, inclusion: { in: Rails.configuration.ofx['standard_change_status'].keys, message: 'is not a valid status' }
end
