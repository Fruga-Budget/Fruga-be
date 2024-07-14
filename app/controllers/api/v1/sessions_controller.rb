class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      render json: { message: 'Logged in successfully' }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    if session[:user_id]
      session.delete(:user_id)
      render json: { message: 'Logged out successfully' }, status: :ok
    else
      render json: { error: 'No active session' }, status: :unauthorized
    end
  end

  def session_params
    params.permit(:email, :password)
  end
end