class AuthController < ApplicationController
  def login
    user = User.find_by(username: auth_params[:username])

    if user && user.authenticate(auth_params[:password])
      set_cookies(user.id)

      render json: user, only: [ :username, :id, :first_name, :last_name]
    else  
      render json: {error: "Username/Password is incorrect"}, status: 403
    end
  end

  def create
    user = User.new(create_params)

    if user.save
      set_cookies(user.id)

      render json: user, only: [ :username, :id, :first_name, :last_name]
    else
      render json: {error: user.errors.full_messages}, status: 422
    end
  end


  def logout
    cookies.delete(:logged_user)
    render json: nil
  end

  def verify_user
    if authenticate_user
      set_cookies(@current_user.id)
      render json: @current_user, only: [ :username, :id]
    else
      render json: nil
    end
  end
  
  private

  def set_cookies(user_id)
    cookies.encrypted[:logged_user] = {
        value: user_id,
        http_only: true,
        secure: true
      }
  end

  def auth_params
    params.require(:auth).permit(:username, :password)
  end

  def create_params
     params.require(:auth).permit(:username, :password, :password_confirmation, :first_name, :last_name)
  end
end
