class Api::V1::UsersController < Api::ApiController
  before_action :api_authorized, only: [:auto_login]

  def create
    @user = User.new(user_params)
    if @user.save?
      token = encode_token({ user_id: @user.id })
      render json: UserSerializer.new(@user, { params: { token: token } })
    else
      raise ActiveRecord::RecordInvalid.new(@user)
    end
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user && @User.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: "Invalid username or password" }
    end
  end

  def auto_login
    render json: @user
  end

  private

  def user_params
    params.permit(:email, :password, :first_name, :last_initial)
  end
end