require 'test_helper'
require 'shoulda-callback-matchers'

include Shoulda::Callback::Matchers::ActiveModel

class StandardChangeTest < ActiveSupport::TestCase

  # callbacks
  should callback(:sanitize_textareas).before(:validation)

  # version
  should belong_to(:version)
  
  # committee
  should validate_presence_of(:committee)
  should allow_value("<ul>\n<li>Member 1</li>\n<li>Member 2</li></ul>").for(:committee)
  
  # title
  should validate_presence_of(:title)
  
  #type
  should ensure_inclusion_of(:type).in_array(Rails.configuration.ofx[:standard_change_type].keys)

  #status
  should ensure_inclusion_of(:status).in_array(Rails.configuration.ofx[:standard_change_status].keys)

  # overview
  should validate_presence_of(:overview)
  should allow_value("<ul>\n<li>Member 1</li>\n<li>Member 2</li></ul>").for(:overview)

  # solution
  should allow_value("<ul>\n<li>Member 1</li>\n<li>Member 2</li></ul>").for(:solution)

  # status_details
  should allow_value("<ul>\n<li>Member 1</li>\n<li>Member 2</li></ul>").for(:status_details)

end
