class AdminMailer < ActionMailer::Base
  default from: 'tim@wordsareimages.com'
  
  def new_user_waiting_for_approval
    cfg = Rails.configuration.action_mailer.default_url_options
    @waiting_users = User.where(approved: false).to_a
    @admin_url = "#{cfg[:protocol]}#{cfg[:host]}#{cfg[:port]}/users"

    user_admins = User.get_user_admin_users
    user_admins.each do |ua|
      mail(to: ua.email, subject: 'OFX users are waiting for approval').deliver
    end
  end
  
  def notify_of_standard_change(standard_change)
    @name = User.friendly.find(standard_change.last_editor_id).name
    @title = standard_change.title
    cfg = Rails.configuration.action_mailer.default_url_options
    @url = "#{cfg[:protocol]}#{cfg[:host]}#{cfg[:port]}/standard_change/#{standard_change.slug}"
    @version = standard_change.version.version
    subscribers = User.where(notifications: true).to_a.each do |u|
      mail(to: u.email, subject: "OFX Standards discussion for #{@title} (v. #{@version})").deliver
    end
  end

  def notify_of_comment(comment)
    @name = User.friendly.find(comment.user_id).name
    standard_change = StandardChange.friendly.find(comment.commentable_id) if comment.commentable_type == 'StandardChange'
    @title = standard_change.title
    cfg = Rails.configuration.action_mailer.default_url_options
    @url = "#{cfg[:protocol]}#{cfg[:host]}#{cfg[:port]}/standard_change/#{standard_change.slug}"
    @version = standard_change.version.version
    subscribers = User.where(notifications: true).to_a.each do |u|
      mail(to: u.email, subject: "OFX Standards discussion: comment on #{@title} (v. #{@version})").deliver
    end
  end
end
