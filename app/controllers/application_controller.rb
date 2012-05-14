# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user  

private

  def current_user
#    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user ||= User.find_by_id_and_activated(session[:user_id], true) if session[:user_id]
  end
  
  def categories
    Categories.all
  end
 
  def require_login
    unless logged_in?
      redirect_to root_url, alert: "Vous devez vous connecter pour accéder à cette section"
    end
  end
  
  def require_admin
    unless (logged_in? && current_user.admin)
      redirect_to root_url, alert: "Manque de pot! pas autorisé à accéder à cette section"
    end
  end
 
  # really mean to convert something into true or false.
  def logged_in?
    !!current_user
  end
end

