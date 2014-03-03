module MinutesHelper
  def get_meeting_types
    Rails.configuration.ofx[:meeting_type].map { |k, v| [v, k] }
  end
  
  def textify(key)
    Rails.configuration.ofx[:meeting_type][key]
  end
end
