module MinutesHelper
  def get_meeting_types
    [
      {
        :id => 'agm',
        :text => 'Association General Meeting'
      },
      {
        :id => 'dirm',
        :text => 'Directors Meeting'
      }
    ]
  end
end
