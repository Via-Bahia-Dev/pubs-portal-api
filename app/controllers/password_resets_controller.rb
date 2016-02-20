class PasswordResetsController < ApplicationController
  skip_before_action :authenticate!, only: [:create, :update]
	authorize_resource :class => false

  def create
    @user = User.find_by_email(params[:email])
    @user.send_password_reset if @user
    head :no_content
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      render json: { errors: { password_reset_token: "has expired"} }, status: :unprocessable_entity
    elsif @user.update_attributes(user_password_params)
      head :no_content
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private
  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
