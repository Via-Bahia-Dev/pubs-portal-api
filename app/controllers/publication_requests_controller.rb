class PublicationRequestsController < ApplicationController

  load_and_authorize_resource

  def create
    @publication_request = PublicationRequest.new(publication_request_params)

    if @publication_request.save
      render json: { data: @publication_request }, status: :created
    else
      render json: { errors: @publication_request.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @publication_request.update(publication_request_params)
      head :no_content
    else
      render json: { errors: @publication_request.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @publication_request.destroy
    head :no_content
  end

  def index
    @publication_requests = PublicationRequest.all
    render json: { data: @publication_requests }, include: ['request_attachments', 'comments']
  end

  def show
    render json: { data: @publication_request }
  end

  private

  def publication_request_params
    params.require(:publication_request).permit(:event, :description, :dimensions, :rough_date, :due_date, :event_date, :user_id, :admin_id, :reviewer_id, :designer_id, :status)
  end

end
