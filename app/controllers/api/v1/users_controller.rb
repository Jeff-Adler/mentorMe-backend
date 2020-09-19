class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  before_action :find_user, only: [:update]
 
  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end
 
  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token({ user_id: @user.id })
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  def update
    @user.update(user_edit_params)
    render json: {user: UserSerializer.new(@user)}
  end
 
  private
 
  def find_user
    @user = User.find(params[:id])
  end

  def user_edit_params
    params.require(:user).permit(:username,:birthdate,:gender,:avatar,:karma).select { |k, v| !v.nil? }
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
