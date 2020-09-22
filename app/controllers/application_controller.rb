class ApplicationController < ActionController::Base
  before_action :set_uuid

  def set_uuid
    cookies[:uuid] = request.uuid
    cookies[:uuid] = current_user.username if current_user
  end    
end
