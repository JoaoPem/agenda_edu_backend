class AuthenticationController < ApplicationController
  skip_before_action :authenticate
  def login
    user = User.find_by(email: params[:user][:email])
    if user&.authenticate(params[:user][:password])
      token = JsonWebToken.encode(user_id: user.id)
      expires_at = JsonWebToken.decode(token)[:exp]
      render json: { token:, expires_at: }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end
end
