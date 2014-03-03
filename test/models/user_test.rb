require 'test_helper'
require 'paperclip/matchers'

include Paperclip::Shoulda::Matchers

class UserTest < ActiveSupport::TestCase
  
  # email
  should validate_presence_of(:email)
  build(:user)   # Need a user to validate uniqueness
  should validate_uniqueness_of(:email)
  
  # approved
  should allow_values(true, false).for(:approved)
  
  # company_or_org
  should validate_presence_of(:company_or_org)
  
  # name
  should validate_presence_of(:name).for(:user)
  
  # avatar
  should allow_value('avatar.jpg','avatar.png', 'avatar.gif').for(:avatar_file_name)
  should_not allow_value('avatar','avatar.txt', 'avatar.tiff').for(:avatar_file_name)
  should have_attached_file(:avatar)
  should validate_attachment_content_type(:avatar).
    allowing('image/jpg', 'image/gif', 'image/png').
    rejecting('application/pdf', 'text/plain')
end
