class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize
  include SessionsHelper


  def detect_browser
    user_agent =  request.env['HTTP_USER_AGENT'].downcase
    if user_agent.index('ipad')
      'ipad'
    elsif user_agent.index('iphone')
      'iphone'
    elsif user_agent.index('android')
      'android'
    else
      'unknown'
    end
  end
  protected
  def authorize
    if session[:user_id].nil?
      redirect_to login_url, alert: 'вы не авторизованы'
    end
  end
end
