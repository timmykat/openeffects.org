require 'test_helper'
require 'shoulda-callback-matchers'

include Shoulda::Callback::Matchers::ActiveModel

class CommentTest < ActiveSupport::TestCase

  # callbacks
  should callback(:sanitize_textareas).before(:validation)

  # comment
  should validate_presence_of(:comment)
  should allow_value('<p>This is my brilliant comment</p>').for(:comment)
  
  #title
  should allow_value('This is my title').for(:title)
end