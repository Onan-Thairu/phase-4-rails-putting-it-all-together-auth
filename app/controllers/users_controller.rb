class UsersController < ApplicationController

  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      render json: {id: user.id, username: user.username, image_url: user.image_url, bio: user.bio}, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    user = User.find_by(id: session[:user_id])
    if user
      render json: {id: user.id, username: user.username, image_url: user.image_url, bio: user.bio}, status: :created
    else
      render json: { error: 'Not authorized' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation, :image_url, :bio)
  end

end
