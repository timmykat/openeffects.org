module MinutesHelper
  def get_meeting_types
    MEETING_TYPES.map { |k, v| [v, k] }
  end
  
  def textify(key)
    MEETING_TYPES[key]
  end
end
