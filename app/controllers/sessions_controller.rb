class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if(user.activated)
      redirect_to root_url
    else
    redirect_to root_url, notice: "Bienvenue, "+user.first_name+".Donnes nous 24 - 48 heures pour activer ton compte"
    end
  end

  def destroy
    session[:user_id] = nil
#    redirect_to root_url, notice: "Signed out!"
    redirect_to root_url
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end
end
