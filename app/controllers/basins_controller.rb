class BasinsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_basin, only: [:show, :edit, :update, :destroy, :edit_form]

  # GET /basins
  # GET /basins.json
  def index
    @basins = Basin.all
  end

  # GET /basins/1
  # GET /basins/1.json
  def show
  end

  # GET /basins/new
  def new
    @basin = Basin.new
  end

  # GET /basins/1/edit
  def edit
    @embed = false
  end

  # GET /basins/1/edit_form
  def edit_form
    @embed = true
    render '_form', layout: false
  end
  
  # POST /basins
  # POST /basins.json
  def create
    @basin = Basin.new(basin_params)
    respond_to do |format|
      if @basin.save
        format.html { 
          if params[:embed] && params[:embed] == 'true' 
            redirect_to @basin, notice: 'Basin was successfully created.' 
          else
            redirect_to edit_site_path(@basin.zone.site, active_panel: @active_panel)
          end
          }
        format.json { render :show, status: :created, location: @basin }
      else
        format.html { render :new }
        format.json { render json: @basin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /basins/1
  # PATCH/PUT /basins/1.json
  def update
    @active_panel = params["active_panel"]
    respond_to do |format|
      if @basin.update(basin_params)
        if @active_panel.nil?
          format.html { redirect_to @basin, notice: 'Basin was successfully updated.' }
        else
          format.html { redirect_to edit_site_path(@basin.zone.site, active_panel: @active_panel) }
        end
        format.json { render :show, status: :ok, location: @basin }
      else
        format.html { render :edit }
        format.json { render json: @basin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /basins/1
  # DELETE /basins/1.json
  def destroy
    @basin.archive
    respond_to do |format|
      format.html { redirect_to basins_url, notice: 'Basin was successfully archived.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_basin
      @basin = Basin.new(site_id: params[:site_id]) if params[:id] == "new"
      @basin = Basin.find(params[:id]) unless params[:id] == "new"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def basin_params
      params.require(:basin).permit(:site_id, :name, :basin_type, :depth, :width, :length, :diameter, :volume, :surface_area, :side_slope_ratio)
    end
end
