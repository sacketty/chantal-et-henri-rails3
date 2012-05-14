class UploadsController < ApplicationController
  before_filter :require_login
  
  def index
    @uploads=current_user.direct_uploads.page(params[:page]).per(8)
  end
  
  def all
    @who = "les"
    @uploads=Upload.page(params[:page]).per(8)
    render action: "index"
  end

  # PUT /uploads/1
  # PUT /uploads/1.json
  def update
    @ul = Upload.find(params[:id])
    respond_to do |format|
      if @ul.update_attributes(params[:upload])
        format.html do
          @song = current_user.songs.find_by_upload_id(@ul.id)
          if(@song)
            @song.update_attributes(params[:upload])
          else
            @song = Song.new(params[:upload])
            @song.user = current_user
            @song.upload = @ul
            @song.save
          end
          redirect_to(session[:return_to] || uploads_path)
          session[:return_to]=nil
#          @songs = current_user.songs
#          render action: "show"
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ul.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    session[:return_to] = request.referer
    @ul = Upload.find_by_id(params[:id])

    respond_to do |format|
      if(@ul)
        format.html # show.html.erb
        format.json { render json: @ul }
      else
        format.html { redirect_to uploads_url, alert: 'Requete invalide' }
        format.json { render json: {}, status: :unprocessable_entity }
      end
    end
  end

  # GET /uploads/1/edit
  def edit
    @ul = Upload.find(params[:id])
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @ul = Upload.find(params[:id])
    @ul.destroy if @ul
    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end
  # POST /uploads
  # POST /uploads.json
  def create
    @ul = Upload.new(params[:upload])
    @ul.added_by = current_user
    @ul.titre = @ul.key
    respond_to do |format|
      if @ul.save
        s=Song.new(titre: @ul.titre)
        s.upload= @ul
        s.user=current_user
        s.save
#        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.html do
          @songs = current_user.songs
          render action: "index"
        end
        format.json { render json: @ul, status: :created, location: @ul }
      else
        format.html { render action: "new" }
        format.json { render json: @ul.errors, status: :unprocessable_entity }
      end
    end
  end
   
  def new   
  end
end
