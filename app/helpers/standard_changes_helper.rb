module StandardChangesHelper
  def get_change_selection(type)
    Rails.configuration.ofx["standard_change_#{type.to_s}".to_sym].map { |k, v| [v, k] }
  end  
end
