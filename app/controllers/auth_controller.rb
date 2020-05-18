class AuthController < ApplicationController
  def login
    user = User.find_by(username: auth_params[:username])

    if user && user.authenticate(auth_params[:password])
      cookies.encrypted[:logged_user] = {value:  user.id, secure: true}
      render json: user, only: [:id, :username]
    else  
      render json: {error: "Username/Password is incorrect"}, status: 403
    end
  end


  def logout
    cookies.delete(:logged_user)
  end
  
  private

  def auth_params
    params.require(:auth).permit(:username, :password)
  end
end
