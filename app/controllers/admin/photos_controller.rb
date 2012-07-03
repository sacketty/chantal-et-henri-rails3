module Admin
  class PhotosController < ApplicationController
    before_filter :require_admin
    # GET /photos
    # GET /photos.json
    def index
      @photos = Photo.all
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @photos }
      end
    end

    # GET /photos/1
    # GET /photos/1.json
    def show
      if(params[:id]=='to-accept')
        @photos = Photo.to_accept
        return render :index
      end
      @photo = Photo.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @photo }
      end
    end


    # GET /photos/1/edit
    def edit
      @photo = Photo.find(params[:id])
    end

    # PUT /photos/1
    # PUT /photos/1.json
    def update
      @photo = Photo.find(params[:id])
      @photo.accepted = !@photo.accepted  
      respond_to do |format|
        if @photo.save
          format.html { redirect_to admin_photos_url, notice: 'Photo was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { redirect_to admin_photos_url , alert: @photo.errors.full_messages}
          format.json { render json: @photo.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /photos/1
    # DELETE /photos/1.json
    def destroy
      @photo = Photo.find(params[:id])
      @photo.destroy

      respond_to do |format|
        format.html { redirect_to admin_photos_url }
        format.json { head :no_content }
      end
    end
  end
end