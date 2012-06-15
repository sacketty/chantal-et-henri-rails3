class GuestsController < ApplicationController

  def index
  end

  def new
    @guest = Guest.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guest }
    end
  end
  
  def create
    @guest = current_user.guests.build(params[:guest])
#    raise 'params[:guest]='+params[:guest].inspect
    respond_to do |format|
      if @guest.save
        @user=@guest
#        format.html { redirect_to @guest, notice: 'Invite enregistre' }
        format.html do
          render action: "index"
        end
        format.json { render json: @guest, status: :created, location: @guest }
      else
        format.html { render action: "new" }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @guest = params[:id].to_i == current_user.id ? current_user : current_user.guests.find(params[:id])
  end
  
  # GET /users/1/edit
  def edit
    @guest = current_user.guests.find_by_id(params[:id])
    @guest ||=current_user
  end
  
  # PUT /users/1
  # PUT /users/1.json
  def update
    @guest = params[:id].to_i == current_user.id ? current_user : current_user.guests.find(params[:id])
    respond_to do |format|
      if (@guest.update_attributes(params[:guest]))
        format.html do
          render action: "index"
        end
        format.json { head :no_content }
      else
        msg = 'Requete invalide\n' + @guest.errors.full_messages
        format.html { redirect_to guests_url, alert: msg }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
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

end
