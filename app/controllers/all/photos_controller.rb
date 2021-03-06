module All
  class PhotosController < ApplicationController
  #  before_filter :require_login
    # GET /photos
    # GET /photos.json
    def index
      @photos = Photo.accepted.page(params[:page]).per(36)
#      @photos = Photo.accepted
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
    
    def diaporama
    end
    
  end
end
