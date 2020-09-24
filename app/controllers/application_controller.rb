class ApplicationController < ActionController::API
  include ::ActionController::Cookies

   def authenticate_user
    user_id = cookies.encrypted[:logged_user]
    @current_user = User.find_by(id: user_id)
  end
end
