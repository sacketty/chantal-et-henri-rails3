class PhotosController < ApplicationController
#  before_filter :require_login
  # GET /photos
  # GET /photos.json
  def index
    @user = current_user
    @photos = @user.photos
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @user = current_user
    @photo = @user.photos.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.json
  def create
#    raise params.inspect
#    @photo = Photo.new(params[:photo])
    @user = User.find(params[:user_id])
    @photo = @user.photos.build
#    @photo.name = params[:photo][:image].original_filename if params[:photo][:name].length == 0
    @photo.name = params['Filename'] 
    @photo.image = params['Filedata']
#    raise @photo.inspect
    respond_to do |format|
      if @photo.save
#        @photos = @user.photos
        format.html { render action: new, notice: 'Photo was successfully created.' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { redirect_to @photo, alert: @photo.errors.full_messages }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def exists 
    val=0
    begin
      PhotoBox.find("uploads/#{params['Filename']}")
      val=1
    rescue
      val=0
    end    
    render text: val
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    respond_to do |format|
      if(@photo.accepted)
        format.html { redirect_to photos_url, alert: "Impossible de supprimer cette photo" }
        format.json { head :no_content }
      else
        @photo.destroy
        format.html { redirect_to photos_url }
        format.json { head :no_content }
      end
    end
  end
end
