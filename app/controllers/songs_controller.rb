class SongsController < ApplicationController
  before_filter :require_login
  # GET /songs
  # GET /songs.json
  def index
    @songs = current_user.songs
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end
  
  def all
    @songs = Song.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @song = Song.find_by_id(params[:id])

    respond_to do |format|
      if(@song)
        format.html # show.html.erb
        format.json { render json: @song }
      else
        @songs = current_user.songs
        format.html { redirect_to songs_url, alert: 'Requete invalide' }
        format.json { render json: {}, status: :unprocessable_entity }
      end
    end
  end

  # GET /songs/new
  # GET /songs/new.json
  def new
    @song = Song.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/1/edit
  def edit
    @song = Song.find(params[:id])
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(params[:song])
    @song.user = current_user
    respond_to do |format|
      if @song.save
#        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.html do
          @songs = current_user.songs
          render action: "index"
        end
        format.json { render json: @song, status: :created, location: @song }
      else
        format.html { render action: "new" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.json
  def update
    @song = Song.find(params[:id])
    @song.user = current_user
    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.html do
          @songs = current_user.songs
          render action: "index"
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song = Song.find(params[:id])
    @song.key ? @song.categories.delete_all : @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end
  
end
