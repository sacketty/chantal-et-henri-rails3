module Admin
class GuestsController < ApplicationController
  before_filter :require_admin
  helper_method :sort_column, :sort_direction

  def index
    scope = params[:join] ? Guest.joins(params[:join]).order("#{params[:join]}.#{params[:sort]}") : Guest.order(sort_column + " " + sort_direction)
    @guests=scope.search(params[:search]).page(params[:page]).per(10)
  end
  
  def show
    @guest = User.find(params[:id])
  end
  

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @guest = current_user.guests.find(params[:id])
    respond_to do |format|
        @guest.destroy
        format.html { redirect_to guests_url }
        format.json { head :no_content }
    end
  end

private
  
  def sort_column
    params[:sort] || "name"
  end

  def sort_direction
    params[:direction] || "asc"
  end

end
end
