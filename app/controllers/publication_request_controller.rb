class PublicationRequestController < ApplicationController
  def new
  end

  def create
    @request = PublicationRequest.new(request_params)

    if @request.save
      render json: { data: @request }, status: :created
    else
      render json: { errors: @request.errors }, status: :unprocessable_entity
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
  end

  private

    def request_params
      params.require(:publication_request).permit(:event, :description, :dimensions, :rough_date, :due_date, :event_date, :user_id)
    end

end
