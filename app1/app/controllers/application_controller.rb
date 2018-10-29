class ApplicationController < ActionController::Base
  protect_from_forgery 
  #acts_as_token_authentication_handler_for User, except: [:create]
  #before_action :authenticate_user!, except: [:create]

  def after_sign_in_path_for(resource)
    comments_path 
  end
end
