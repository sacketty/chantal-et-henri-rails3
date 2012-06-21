module Admin
class GuestsController < ApplicationController
  before_filter :require_admin

  def index
    scope = params[:join] ? Guest.joins(params[:join]).order("#{params[:join]}.#{params[:sort]}") : Guest.order(params[:sort])
    @guests=scope.search(params[:search]).page(params[:page]).per(10)
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
