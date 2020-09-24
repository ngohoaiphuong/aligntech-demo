module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user, :current_uuid

    def connect
      self.current_user = find_verified_user
      self.current_uuid = cookies[:uuid]
    end

    protected

    def find_verified_user
      if (current_user = env["warden"].user)
        current_user
      # else
      #   p "2.Cookies"
      #   cookies[:uuid]
      #   # OpenStruct.new({
      #   #   id: cookies[:uuid]
      #   # })
      #   # reject_unauthorized_connection
      end
    end    
  end
end
