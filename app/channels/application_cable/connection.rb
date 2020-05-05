module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      
      # self.current_user = verify_current_user
      # byebug
      puts 'connection established'
    end

    private

    def verify_current_user

      if verified_user = User.find(cookies.signed[:user_id])
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
