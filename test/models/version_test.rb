require 'test_helper'

class VersionTest < ActiveSupport::TestCase
 
  # version
  should validate_presence_of(:version)
  should allow_value('1.1', '10.1', '1.2.3').for(:version)
  should_not allow_value('ab', '2a', '1.4a').for(:version)
 
  # status
  should ensure_inclusion_of(:status).in_array(Rails.configuration.ofx[:version_status].keys)
  
  # current
  should allow_value(true, false).for(:current)
  
 end
