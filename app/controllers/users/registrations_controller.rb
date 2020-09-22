# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include ErrorMessageHelper
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    ActiveRecord::Base.transaction do
      user_param = user_params

      if !User.by_user(user_param[:username]).empty?
        return show_error_message('#error-description', t('errors.username.exists', { username: user_param[:username] }), '.auth-btn')
      end

      user = User.new(user_param)
      if !user.valid?
        return show_error_message('#error-description', messages(user.errors.messages.flatten), '.auth-btn')
      end

      if user_param[:password] != user_param[:password_confirmation]
        return show_error_message('#error-description', t('errors.password.incorrect'), '.auth-btn')
      end

      user.save
      resource = User.find_for_database_authentication(username: user_param[:username])
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private
  def user_params
    params.require(:user).permit(
      :username,
      :password,
      :password_confirmation
    )
  end

  def messages(errors)
    errors_ = []
    Hash[*errors].each{|k,v| errors_.push("#{k.to_s.titlecase}: #{v.join(',')}")}
    errors_.join('</br>')
  end
end
