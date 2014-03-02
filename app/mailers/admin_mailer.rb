class AdminMailer < ActionMailer::Base
  default from: 'tim@wordsareimages.com'
  
  def new_user_waiting_for_approval
    @waiting_users = User.where(approved: false).to_a
    user_admins = User.get_user_admin_users
    user_admins.each do |ua|
      mail(to: ua.email, subject: 'OFX users are waiting for approval')
    end
  end
end
