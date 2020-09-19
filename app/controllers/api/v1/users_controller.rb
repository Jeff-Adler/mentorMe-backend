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
    @user.update_attribute(:username, user_edit_params[:username]) unless user_edit_params[:username] == null
    @user.update_attribute(:birthdate, user_edit_params[:birthdate]) unless user_edit_params[:birthdate] == null
    @user.update_attribute(:gender, user_edit_params[:gender]) unless user_edit_params[:gender] == null
    @user.update_attribute(:avatar, user_edit_params[:avatar]) unless user_edit_params[:avatar] == null
    @user.update_attribute(:karma, user_edit_params[:karma]) unless user_edit_params[:karma] == null
    render json: {user: UserSerializer.new(@user)}
  end
 
  private
 
  def find_user
    @user = User.find(params[:id])
  end

  def user_edit_params
    params.require(:user).permit(:username,:birthdate,:gender,:avatar,:karma)
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
