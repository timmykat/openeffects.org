module ApplicationHelper
  def get_version_status_selection
    Rails.configuration.ofx[:version_status].map { |k, v| [v, k] }
  end  
end
