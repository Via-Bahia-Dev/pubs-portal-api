class RequestAttachmentsController < ApplicationController

  load_and_authorize_resource

  def create
    @request_attachment = RequestAttachment.new(request_attachment_params)

    if @request_attachment.save
      render json: { data: @request_attachment }, status: :created
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
    @request_attachments = RequestAttachment.all
    render json: { data: @request_attachments }
  end

  def show
    puts @request_attachment.request_attachment_urls
    render json: { data: @request_attachment }, :methods => :request_attachment_urls
  end

  private

  def request_attachment_params
    params.require(:request_attachment).permit(:publication_request_id, :file, :user_id, :comment)
  end

end
