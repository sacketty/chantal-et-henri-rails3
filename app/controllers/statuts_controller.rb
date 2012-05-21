class StatutsController < ApplicationController
  before_filter :require_admin
  
  def index
    @statuts=Statut.page(params[:page]).per(10)
  end
end
