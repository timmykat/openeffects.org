class ContactFormController < ApplicationController
  def display
    @user = current_user
  end
  
  def send_form_mail
    AdminMailer.contact_form(contact_form_params)
    flash[:notice] = "Thanks for your message!"
    redirect_to :root
  end
  
  private
    def contact_form_params
      params[:contact_form].permit(:name, :email, :destination, :subject, :message)
    end
end
