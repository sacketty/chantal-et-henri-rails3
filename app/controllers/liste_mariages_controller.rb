class ListeMariagesController < ApplicationController
  # GET /liste_mariages
  # GET /liste_mariages.json
  def index
    @liste_mariages = ListeMariage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @liste_mariages }
    end
  end

  # GET /liste_mariages/1
  # GET /liste_mariages/1.json
  def show
    @liste_mariage = ListeMariage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @liste_mariage }
    end
  end

  # GET /liste_mariages/new
  # GET /liste_mariages/new.json
  def new
    @liste_mariage = ListeMariage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @liste_mariage }
    end
  end

  # GET /liste_mariages/1/edit
  def edit
    @liste_mariage = ListeMariage.find(params[:id])
  end

  # POST /liste_mariages
  # POST /liste_mariages.json
  def create
    @liste_mariage = ListeMariage.new(params[:liste_mariage])

    respond_to do |format|
      if @liste_mariage.save
        format.html { redirect_to @liste_mariage, notice: 'Liste mariage was successfully created.' }
        format.json { render json: @liste_mariage, status: :created, location: @liste_mariage }
      else
        format.html { render action: "new" }
        format.json { render json: @liste_mariage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /liste_mariages/1
  # PUT /liste_mariages/1.json
  def update
    @liste_mariage = ListeMariage.find(params[:id])

    respond_to do |format|
      if @liste_mariage.update_attributes(params[:liste_mariage])
        format.html { redirect_to @liste_mariage, notice: 'Liste mariage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @liste_mariage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /liste_mariages/1
  # DELETE /liste_mariages/1.json
  def destroy
    @liste_mariage = ListeMariage.find(params[:id])
    @liste_mariage.destroy

    respond_to do |format|
      format.html { redirect_to liste_mariages_url }
      format.json { head :no_content }
    end
  end
end
