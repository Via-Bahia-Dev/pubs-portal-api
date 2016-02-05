class PublicationRequestsController < ApplicationController

  load_and_authorize_resource

  def create
    @publication_request = PublicationRequest.new(publication_request_params)
    @publication_request.user_id = current_user.id

    if @publication_request.status.nil?
      @publication_request.status = Status.find_by_name("Submitted")
    end

    if @publication_request.save
      render json: { data: serialized_objects(@publication_request) }, status: :created
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
    render json: { data: serialized_objects(@publication_requests) }
  end

  def show
    render json: { data: serialized_objects(@publication_request) }
  end

  private

  def publication_request_params
    params.require(:publication_request).permit(:event, :description, :dimensions, :rough_date, :due_date, :event_date, :admin_id, :reviewer_id, :designer_id, :status, :template_id)
  end

end
