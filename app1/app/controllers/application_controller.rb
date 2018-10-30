class ApplicationController < ActionController::Base
  protect_from_forgery
  acts_as_token_authentication_handler_for User
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    comments_path 
  end
end
