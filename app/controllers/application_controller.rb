class ApplicationController < ActionController::API
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  include CanCan::ControllerAdditions

  include WardenHelper

	rescue_from ActiveRecord::RecordNotFound,       with: :not_found
  rescue_from ActionController::ParameterMissing, with: :missing_param_error
  rescue_from CanCan::AccessDenied,               with: :access_denied

  def not_found
    render status: :not_found, json: ""
  end

  def missing_param_error(exception)
    render status: :unprocessable_entity, json: { errors: exception.message }
  end

  def access_denied(exception)
    render status: :forbidden, json: { errors: exception.message }
  end
end
