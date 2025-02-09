class ApplicationController < ActionController::API
  before_action :authenticate

  rescue_from CanCan::AccessDenied, with: :access_denied

  attr_reader :current_user

  def route_not_found
    render json: { errors: "No route matches #{request.method} '#{request.path}'" }, status: :not_found
  end

  private

  def authenticate
    header = request.headers["Authorization"]
    token  = header.split(" ").last if header

    if header.blank?
      render json: { errors: "Authorization header is missing" }, status: :unauthorized
      return
    end

    begin
      @decoded = JsonWebToken.decode(token)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def access_denied
    render json: { error: "Access Denied: You do not have permission to perform this action." }, status: :forbidden
  end
end
