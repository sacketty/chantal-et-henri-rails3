class StatutController < ApplicationController
  before_filter :require_login
  # GET /statuts
  # GET /statuts.json

  # GET /statuts/1
  # GET /statuts/1.json
  def index
    @statut = get_statut

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @statut }
    end
  end

  # GET /statuts/1/edit
  def edit
    session[:return_to] = request.referer
    @statut = get_statut
  end
  
  def show
    @statut = get_statut
    render "index"
  end

  # PUT /statuts/1
  # PUT /statuts/1.json
  def update
    @statut = get_statut

    respond_to do |format|
      if @statut.update_attributes(params[:statut])
        format.html { redirect_to @statut, notice: 'Statut was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @statut.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuts/1
  # DELETE /statuts/1.json
  def destroy
    @statut = Statut.find(params[:id])
    @statut.destroy if ((@statut.user_id == current_user.id) || current_user.admin)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
end
