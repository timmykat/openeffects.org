class Version < ActiveRecord::Base
  validates :version, presence: true
  validates :version, format: { with: /\A\d+\.\d+(\.\d+)?\z/, message: 'must have the format #.# or #.#.#' }
  validates :status, inclusion: { in: Rails.configuration.ofx[:version_status].map { |k,v| k.to_s }, message: 'is not a valid version status' }
  validates :current, :inclusion => { in: [true, false] }
  
  has_many :standard_changes
  validates_associated :standard_changes
end
