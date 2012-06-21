module Admin
class GuestsController < ApplicationController
  before_filter :require_admin

  def index
  end
  
  def show
    @guest = User.find(params[:id])
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

end
end