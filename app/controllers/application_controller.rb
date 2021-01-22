class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :authorized

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordNotUnique, with: :render_record_not_unique


  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end

  def encode_token(payload)
    JWT.encode payload, '5copi'
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      @token = auth_header
      begin
        JWT.decode @token, '5copi', true, algorithm: 'HS256'
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']

      @user = User.find_by id: user_id
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def render_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_record_not_unique(exception)
    render json: { error: exception.message }, status: :conflict
  end
end
