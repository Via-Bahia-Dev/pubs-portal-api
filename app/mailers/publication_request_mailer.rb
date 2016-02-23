class PublicationRequestMailer < ApplicationMailer

  def request_created(request, user_role)
    @user_role = user_role
    @request = request
    mail(to: User.find(@request.attributes["#{user_role}_id"]).email,
         subject: "Publication Request for #{request.event} assigned to you as #{user_role}",
         template_name: 'request_created')
  end
end
