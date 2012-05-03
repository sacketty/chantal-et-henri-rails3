# encoding: utf-8
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if(user.activated)
      redirect_to root_url
    else
      name = user.first_name
      name ||= user.name
      puts "--------"
      puts env["omniauth.auth"].inspect
      redirect_to root_url, notice: "Bienvenue, "+ name +". Donnes nous 24 - 48 heures pour activer ton compte"
    end
  end

  def destroy
    session[:user_id] = nil
#    redirect_to root_url, notice: "Signed out!"
    redirect_to root_url
  end

  def failure
    redirect_to root_url, alert: "Authentification échouée. Essaye encore ..."
  end
end
