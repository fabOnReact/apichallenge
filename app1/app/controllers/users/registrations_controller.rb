# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    
    respond_to do |format|
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          format.json { render json: resource, status: :created }
          format.html { respond_with resource, location: after_sign_up_path_for(resource) }
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          format.json { render json: resource, status: :created }
          format.html { respond_with resource, location: after_inactive_sign_up_path_for(resource) }
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        format.json { render json: resource, status: :unprocessable_entity }
        format.html { respond_with resource }
      end
    end
  end

  # protected
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  #  def after_sign_up_path_for(resource)
  #   super(resource)
  #  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
