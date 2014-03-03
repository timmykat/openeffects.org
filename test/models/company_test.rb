require 'test_helper'
require 'paperclip/matchers'
require 'shoulda-callback-matchers'

include Paperclip::Shoulda::Matchers
include Shoulda::Callback::Matchers::ActiveModel

class CompanyTest < ActiveSupport::TestCase 

  # callbacks
  should callback(:sanitize_textareas).before(:validation)

  # contact
  should belong_to(:contact).class_name('User')
  
  # name
  should validate_presence_of(:name)
  should validate_presence_of(:url)
  
  # url
  should allow_value('http://foo.com','http://foo.com/bar', 'https://foo.com').for(:url)
  should_not allow_value('asdf','ftp://foo.bar', 'mailto:foo.com').for(:url)
  
  # logo (attachment)
  should allow_value('logo.jpg','logo.png', 'logo.gif').for(:logo_file_name)
  should_not allow_value('logo','logo.txt', 'logo.tiff').for(:logo_file_name)
  should have_attached_file(:logo)
  should validate_attachment_content_type(:logo).
    allowing('image/jpg', 'image/gif', 'image/png').
    rejecting('application/pdf', 'text/plain')
end
