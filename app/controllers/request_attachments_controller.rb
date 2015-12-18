class RequestAttachmentsController < ApplicationController

  load_and_authorize_resource

  def create
    @request_attachment = RequestAttachment.new(request_attachment_params)
    @request_attachment.publication_request_id = params[:publication_request_id]
    @request_attachment.user_id = current_user.id

    if @request_attachment.save
      render json: { data: serialized_objects(@request_attachment) }, status: :created
    else
      render json: { errors: @request_attachment.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @request_attachment.update(request_attachment_params)
      head :no_content
    else
      render json: { errors: @request_attachment.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @request_attachment.destroy
    head :no_content
  end

  def index
    render json: { data: serialized_objects(@request_attachments) }
  end

  def show
    render json: { data: serialized_objects(@request_attachment) }, :methods => :request_attachment_urls
  end

  private

  def request_attachment_params
    params.require(:request_attachment).permit(:file, :comment)
  end

end
