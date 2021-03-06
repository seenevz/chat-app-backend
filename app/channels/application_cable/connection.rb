module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = verify_current_user
      puts "connection established by #{current_user.username}"
    end

    private

    def verify_current_user

      if verified_user = User.find_by(id: cookies.encrypted[:logged_user])
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
