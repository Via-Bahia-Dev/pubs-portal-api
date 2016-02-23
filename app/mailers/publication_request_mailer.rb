class PublicationRequestMailer < ApplicationMailer

  def request_created_designer(request)
    @email_for = :designer
    @request = request
    mail(to: @designer.email,
         subject: "Publication Request for #{request.event} assigned to you as designer",
         template_name: 'request_created')

  end

  def request_created_reviewer(request)
    @email_for = :reviewer
    @request = request
    mail(to: @reviewer.email,
         subject: "Publication Request for #{request.event} assigned to you as reviewer",
         template_name: 'request_created')
  end
end
