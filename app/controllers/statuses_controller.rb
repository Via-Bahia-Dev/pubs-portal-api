class StatusesController < ApplicationController
  load_and_authorize_resource

  def index
    render json: { data: serialized_objects(@statuses) }
  end

  def show
    render json: { data: serialized_objects(@status) }
  end

  def create
    @status = Status.new(status_params)
    if @status.save
      render json: { data: serialized_objects(@status) }, status: :created
    else
      render json: { errors: @status.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @status.update(status_params)
      head :no_content
    else
      render json: { errors: @status.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @status.destroy
    head :no_content
  end

  private

  def status_params
    params.require(:status).permit(:name)
  end
end
