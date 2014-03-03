require 'test_helper'
require 'shoulda-callback-matchers'

include Shoulda::Callback::Matchers::ActiveModel

class NewsItemTest < ActiveSupport::TestCase

  # callbacks
  should callback(:sanitize_textareas).before(:validation)

  # published
  should allow_value(true, false).for(:published)

  # headline
  should validate_presence_of(:headline)
  should allow_value('This is my headline').for(:headline)

  # date
  should validate_presence_of(:date)

  should validate_presence_of(:summary)
  should allow_value("<p>Here's the latest OFX news</p>").for(:summary)

end
