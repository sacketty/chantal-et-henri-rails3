class UsersController < ApplicationController
  before_filter :require_admin

  def index
    @users = current_list   
  end
  
  def show
    @user = User.find_by_id(params[:id])
  end
  
  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end
  
  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if (@user != current_user && @user.update_attributes(params[:user]))
        if @user.newly_activated?
          UserMailer.registration_confirmation(@user).deliver
        end
        format.html do
          @users = current_list
          render action: "index"
        end
        format.json { head :no_content }
      else
        msg = @user == current_user ? 'Impossible de modifier ses propres parametres' : 'Requete invalide'
        format.html { redirect_to users_url, alert: msg }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
    
  def toggle
    session[:usr_btn] = params[:btn].to_i
    redirect_to users_url
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    respond_to do |format|
      if(@user == current_user)
        format.html { redirect_to users_url, alert: "Impossible de s'auto supprimer! (n'importe quoi !...)" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      else
        @user.destroy
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
    end
  end

private
  def current_list
    @btn = [false, false, false]
    session[:usr_btn] ||= 1
    @btn[session[:usr_btn]]=true
    case session[:usr_btn]
    when 0
      User.no_guests
    when 1
      User.no_guests(false)
    else
      User.no_guests(true)
    end
    
  end

end
