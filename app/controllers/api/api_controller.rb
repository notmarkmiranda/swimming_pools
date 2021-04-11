class Api::ApiController < ApplicationController
  before_action :api_authorized
  around_action :handle_errors

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base)
  end

  def auth_header
    # { 'Authorization': 'Bearer <token>' }
    request.headers['Authorization']
  end
  
  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>'}
      begin
        JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end
  
  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def api_authorized
    render json: { message: "Please log in" }, status: :unauthorized unless logged_in?
  end

  def handle_errors
    yield
  rescue ActiveRecord::RecordNotFound => e
    render_api_error(e.message, 404)
  rescue ActiveRecord::RecordInvalid => e
    render_api_error(e.record.errors.full_messages, 422)
  # these will be implemented in the future
  # rescue JWT::ExpiredSignature => e
    # render_api_error(e.message, 401)
  # rescue InvalidTokenError => e
    # render_api_error(e.message, 422)
  # rescue MissingTokenError => e
    # render_api_error(e.message, 422)
  end

  def render_api_error(messages, code)
    data = { errors: { code: code, details: Array.wrap(messages) } }
    render json: data, status: code
  end
end