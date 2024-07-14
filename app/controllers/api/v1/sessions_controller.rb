class Api::V1::SessionsController < ApplicationController
  def create
    binding.pry
    user = User.find_by(email: params[:email])
    binding.pry
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { token: token }, status: :ok
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
  end
end