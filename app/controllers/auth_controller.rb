class AuthController < ApplicationController
  def login
    user = User.find_by(username: auth_params[:username])

    if user && user.authenticate(auth_params[:password])
     set_cookies(user.id)

      render json: user, only: [ :username]
    else  
      render json: {error: "Username/Password is incorrect"}, status: 403
    end
  end


  def logout
    cookies.delete(:logged_user)
  end

  def verify_user
    if authenticate_user
      set_cookies(@current_user.id)
      render json: @current_user, only: [ :username]
    end
  end
  
  private

  def set_cookies(user_id)
    cookies.encrypted[:logged_user] = {
        value: user_id,
        http_only: true,
        same_site: 'Lax'
      }
  end

  def auth_params
    params.require(:auth).permit(:username, :password)
  end
end
