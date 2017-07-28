class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session
  protect_from_forgery
  
  # @user = User.new
  
  private
  # this method conflicts with devise
  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end
  # helper_method :current_user
  
  def ignore_exception
    begin
      yield
    rescue Exception
    end
  end
  
  # after_filter :set_csrf_cookie_for_ng
  #
  # def set_csrf_cookie_for_ng
  #   cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  # end
  #
  # protected
  # def verified_request?
  #   super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  # end
end
