class ApplicationController < ActionController::Base
  before_action :set_action_cable_identifier

  def set_action_cable_identifier
    p cookies['channelID']
    cookies[:user_id] = nil
    cookies[:uuid] = SecureRandom.urlsafe_base64 if cookies[:uuid].nil?
    p "uuid: #{cookies['uuid']}"
    cookies[:user_id] = current_user&.id if current_user.present?
  end    

  def after_sign_in_path_for(user)
    set_action_cable_identifier
    root_path
  end
end
