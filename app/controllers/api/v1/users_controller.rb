class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  before_action :find_user, only: [:show, :update, :retrieve_eligible_mentors, :retrieve_pendings]
 
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
    @user.assign_attributes(user_edit_params)
    @user.save(validate: false) #Overrides minimum password character count validation, which wrongly applies otherwise
    render json: {user: UserSerializer.new(@user)}
  end

  def show
    render json: {user: UserSerializer.new(@user)}
  end

  def retrieve_eligible_mentors
    if @user.birthdate
      render json: @user.eligible_mentors
    else
      render json: { error: 'Need to set your birthdate!' }, status: :not_acceptable
    end
  end

  #Retrieves all the users for whom they are the mentor_id in connections
  def retrieve_pendings
    if @user.pendings != nil
      render json: @user.pendings
    else
      render json: { error: 'No pending requests!' }, status: :not_acceptable
    end
  end
 
  private
 
  def find_user
    @user = User.find(params[:id])
  end

  def user_edit_params
    params.require(:user).permit(:username, :password, :birthdate,:gender,:avatar,:karma).select { |k, v| !v.nil? }
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
