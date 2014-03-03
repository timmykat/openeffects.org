require 'test_helper'
require 'paperclip/matchers'
require 'shoulda-callback-matchers'

include Paperclip::Shoulda::Matchers
include Shoulda::Callback::Matchers::ActiveModel

class ContentTest < ActiveSupport::TestCase

  # callbacks
  should callback(:sanitize_textareas).before(:validation)

  # published
  should allow_value(true, false).for(:published)
  
  # identifier
  should validate_presence_of(:identifier)
  should allow_value('allowed_value').for(:identifier)
  should_not allow_value('3abc', 'abc-def', '#$%^').for(:identifier)

  # content
  should allow_value('<p>This is content.</p>').for(:content)
  should allow_value('<li class="level1"><div class="li"> GenArts Inc, represented by Gary Oberbrunner and Alan Lorence</div>
</li>').for(:content)


  # pdf attachment
  should allow_value('file.pdf').for(:pdf_file_name)
  should_not allow_value('file','file.txt', 'file.doc').for(:pdf_file_name)
  should have_attached_file(:pdf)
  should validate_attachment_content_type(:pdf).
    allowing('application/pdf').
    rejecting('application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'text/plain')

  # image attachment
  should allow_value('image.jpg','image.png', 'image.gif').for(:image_file_name)
  should_not allow_value('image','image.txt', 'image.tiff').for(:image_file_name)
  should have_attached_file(:image)
  should validate_attachment_content_type(:image).
    allowing('image/jpg', 'image/gif', 'image/png').
    rejecting('application/pdf', 'text/plain')
end
