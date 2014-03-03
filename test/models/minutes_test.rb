require 'test_helper'
require 'shoulda-callback-matchers'

include Shoulda::Callback::Matchers::ActiveModel

class MinuteTest < ActiveSupport::TestCase

  # callbacks
  should callback(:sanitize_textareas).before(:validation)
  
  # published
  should allow_value(true, false).for(:published)
  
  # meeting
  should validate_presence_of(:meeting)
  should ensure_inclusion_of(:meeting).in_array(Rails.configuration.ofx[:meeting_type].keys)
  
  # date
  should validate_presence_of(:date)
  
  # members
  should allow_value("<ul>\n<li>Member 1</li>\n<li>Member 2</li></ul>").for(:members)

  # observing
  should allow_value("<ul>\n<li>Observer 1</li>\n<li>Observer 2</li></ul>").for(:observing)

  # minutes
  should allow_value("<p>Some html text.</p>").for(:minutes)
end
