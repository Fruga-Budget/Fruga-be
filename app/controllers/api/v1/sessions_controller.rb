class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(user_name: session_params[:user_name])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      render json: UserSerializer.new(user).serializable_hash.to_json, status: :ok
    else
      render json: { error: 'Invalid user name or password' }, status: :unauthorized
    end
  end

  # def destroy
  #   if session[:user_id]
  #     session.delete(:user_id)
  #     render json: { message: 'Logged out successfully' }, status: :ok
  #   else
  #     render json: { error: 'No active session' }, status: :unauthorized
  #   end
  # end

  def session_params
    params.permit(:user_name, :password)
  end
end