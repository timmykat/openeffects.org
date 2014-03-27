module ApplicationHelper
  def get_version_status_selection
    Rails.configuration.ofx[:version_status].map { |k, v| [v, k] }
  end
  
  def get_version_options
    Version.order(version: :desc).to_a.map { |v| [v.version, "v#{v.version.gsub('.','')}"] }
  end
end
