class ApplicationController < ActionController::Base
  before_action :set_uuid

  def set_uuid
    cookies[:uuid] = current_user.username if current_user.present?
  end    

  def after_sign_in_path_for(user)
    cookies[:uuid] = user&.id.to_s
    root_path
  end
end
