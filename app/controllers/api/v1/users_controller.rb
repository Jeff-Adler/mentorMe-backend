require 'httparty'
require 'json'

class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  before_action :find_user, only: [:show, :update, :retrieve_eligible_mentors, :retrieve_pendings,:retrieve_mentor_posts,:retrieve_mentee_posts]
 
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
    if user_edit_params[:gender] && @user.gender == "male" || @user.gender == "female"
      begin
        response = HTTParty.get("https://randomuser.me/api/?gender=#{@user.gender}&noinfo&?seed=#{@user.id}")
        userImage = JSON.parse(response.body)["results"][0]["picture"]["large"]
      rescue JSON::ParserError
        userImage = nil
      end
    @user.avatar = userImage
    end
    @user.save(validate: false) #Overrides minimum password character count validation
    render json: {user: UserSerializer.new(@user)}
  end

  def show
    render json: {user: UserSerializer.new(@user)}
  end

  def retrieve_posts 
    render json: @user.posts
  end

  #returns the type of mentor (professional, interpersonal,etc.) being retrieved
  def retrieve_eligible_mentors
    mentor_type = params[:mentor_type]
    eligible_mentors = @user.eligible_mentors(mentor_type)
    if eligible_mentors != nil
      render json: eligible_mentors
    else
      render json: { error: 'Cannot find any users!' }, status: :not_acceptable
    end
  end

  #Retrieves all the users for whom they are the mentor_id in connections and the associated connections
  def retrieve_pendings
    if @user.pending_connections != nil && @user.pending_users != nil
      render json: {pending_users: @user.pending_users} 
    else
      render json: { error: 'No pending requests!' }, status: :not_acceptable
    end
  end

  def accept_pending
    connection = Connection.find_by(mentee_id: user_accept_params[:user_id], mentor_id: params[:id])
    connection.accepted = true
    connection.save
    post = Post.create(connection: connection)
    if connection.valid? && post.valid?
      render json: connection
    else
        render json: {error: "Could not update connection"}
    end
  end
 
  private
 
  def find_user
    @user = User.find(params[:id])
  end

  def user_edit_params
    params.require(:user).permit(:username, :password, :first_name, :last_name, :birthdate,:gender,:avatar, :professional,:interpersonal,:self_improvement,:description).select { |k, v| !v.nil? }
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def user_accept_params
    params.require(:user).permit(:user_id)
  end
end
