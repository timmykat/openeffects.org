class Version < ActiveRecord::Base
  validates :version, format: { with: /\A\d+\.\d+(\.\d+)?\z/, message: 'must have the format #.# or #.#.#' }
  validates :status, inclusion: { in: Rails.configuration.ofx['version_status'].keys, message: 'is not a valid version status' }
  validates :current, presence: true
  
  has_many :standard_changes
  validates_associated :standard_changes
end
