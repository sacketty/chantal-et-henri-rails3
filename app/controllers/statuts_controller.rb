class StatutsController < ApplicationController
  before_filter :require_admin
  
  def index
    @statuts=Statut.page(params[:page]).per(10)
  end
  
  # GET /statuts/1/edit
  def edit
    @statut = Statut.find(params[:id])
  end
  
  def show
    @statut = Statut.find(params[:id])
    render "edit"
  end
  
  def update
    @statut = Statut.find(params[:id])
    @statut.set_resa_rq(params["statut"])
    if(@statut.delta_s + Room::Single.count > Room::Single::MAX)
      flash[:alert] = "Depassement du nombre de chambres single"
      render :edit
    elsif((@statut.delta_d + Room::Double.count > Room::Double::MAX))
      flash[:alert] = "Depassement du nombre de chambres double"
      render :edit
    else
      Room.update_quantity(@statut)
      flash[:notice] = "Total Chambres doubles: #{Room::Double.count} | Total Chambres single #{Room::Single.count}"
      render :edit
    end
  end
end
