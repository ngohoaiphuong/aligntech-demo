module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :session_id

    def connect
      self.session_id  = cookies[:uuid]
    end

    # identified_by :current_user

    # def connect
    #   self.current_user = find_verified_user
    # end

    # protected

    # def find_verified_user
    #   if (current_user = env["warden"].user)
    #     current_user
    #   else
    #     reject_unauthorized_connection
    #   end
    # end    
  end
end
