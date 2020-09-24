class UsersController < ApplicationController
  def find_user
    byebug
    # user = User.find_by(username: params[:username])
    # render json: user, only: [:id, :username] 
  end
end
