class AuthController < ApplicationController
  def create
    user = User.find_by(auth_params)

    if user
      cookies.signed[:user_id] = {value:  user.id, httponly: true}
      render json: user, only: [:id, :username]
    else
      render json: {error: "Username is incorrect"}, status: 404
    end
  end
  
  private

  def auth_params
    params.require(:user).permit(:username)
  end
end
