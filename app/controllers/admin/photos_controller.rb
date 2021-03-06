module Admin
  class PhotosController < ApplicationController
    before_filter :require_admin
    # GET /photos
    # GET /photos.json
    def index
      session[:to_accept] ||= true
      @to_accept = session[:to_accept]
      @photos = @to_accept ? Photo.to_accept : Photo.all
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
    
    def toggle
      session[:to_accept] = !session[:to_accept]
      redirect_to admin_photos_url
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