class UsersController < ApplicationController
  before_filter :require_admin

  def index    
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
        UserMailer.registration_confirmation(@user) if @user.newly_activated?
        format.html do
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

end
