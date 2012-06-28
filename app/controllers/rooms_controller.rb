class RoomsController < ApplicationController
  before_filter :require_admin
  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.order("id ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rooms }
      format.pdf do
        params[:alt].nil? ? list_rooms : list_guests
      end
    end
  end
  
  def list_rooms
    pdf = RoomsPdf.new(@rooms)
    file = "Rooming List Chantal et Henri"
    send_data pdf.render, filename: file,
        type: "application/pdf", disposition: "inline"
  end
  
  def list_guests
    pdf = GuestsListPdf.new()
    file = "Liste des invites"
    send_data pdf.render, filename: file,
        type: "application/pdf", disposition: "inline"
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @room = Room.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/new
  # GET /rooms/new.json
  def new
    @room = Room.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(params[:room])

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render json: @room, status: :created, location: @room }
      else
        format.html { render action: "new" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    params[:room] = params[:room_single]
    params[:room] ||= params[:room_double]
    @room = Room.find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to room_url, notice: 'Room was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url }
      format.json { head :no_content }
    end
  end
end
