# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include ErrorMessageHelper
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    data = authencation_params
    user = User.find_for_database_authentication(username: data[:username])    
    if user.blank? || !user.valid_password?(data[:password])
      return show_error_message('#error-description', t('devise.failure.invalid'), '.auth-btn')
    end
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private
    def authencation_params
      params.require(:user).permit(:username, :password)
    end
end
