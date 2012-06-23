module Admin
class GuestsController < ApplicationController
  before_filter :require_admin
  helper_method :sort_column, :sort_direction

  def index
    guests_index
  end
  
  def show
    @guest = User.find(params[:id])
  end 
  
  # GET /admin/guests/invite/1/edit
  def invite
    @guest = Guest.find_by_id(params[:id])
  end
  
  # PUT /admin/guests/invite/1
  def update_invite
    @guest = Guest.find(params[:id])
    @guest.invited_by_id = params[:guest][:invited_by_id]
    respond_to do |format|
      if (@guest.save)
        format.html do
          guests_index
          render action: "index"
        end
        format.json { head :no_content }
      else
        msg = "Requete invalide: #{@guest.errors.full_messages}"
        format.html { redirect_to guests_url, alert: msg }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end 
  
  #get /admin/guests/id/invites
  def users_invites
    @guests=User.find(params[:id]).guests.page(params[:page]).per(10)
    render action: "index"
  end
  
  # GET /users/1/edit
  def edit
    @guest = Guest.find_by_id(params[:id])
  end
  
  # PUT /users/1
  # PUT /users/1.json
  def update
    @guest = Guest.find(params[:id])
    respond_to do |format|
      if (@guest.update_attributes(params[:guest]))
        format.html do
          guests_index
          render action: "index"
        end
        format.json { head :no_content }
      else
        msg = "Requete invalide: #{@guest.errors.full_messages}"
        format.html { redirect_to guests_url, alert: msg }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @guest = Guest.find(params[:id])
    respond_to do |format|
        @guest.destroy
        format.html { redirect_to admin_guests_url }
        format.json { head :no_content }
    end
  end

private

  def guests_index
    scope = params[:join] ? Guest.joins(params[:join]).order("#{params[:join]}.#{params[:sort]}") : Guest.order(sort_column + " " + sort_direction)
    @guests=scope.search(params[:search]).page(params[:page]).per(10)
  end
  
  def sort_column
    params[:sort] || "name"
  end

  def sort_direction
    params[:direction] || "asc"
  end

end
end
