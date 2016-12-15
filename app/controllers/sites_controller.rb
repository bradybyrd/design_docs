class SitesController < ApplicationController
  before_filter :authenticate_user_from_token!
  
  before_filter :authenticate_user!
  before_action :set_site, only: [:show, :edit, :update, :destroy, :site_data, :upload]

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.unarchived.ordered
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
  end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # GET /sites/1/edit
  def edit
    @active_panel = params["active_panel"]
    @active_panel = session[:active_panel] if @active_panel.nil?
    @active_panel = '' if @active_panel.nil?
    @properties = @site.properties
    @site.reports.new
    @record = @site
    @current_tab = params["tab"] || "site_details"
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)
    respond_to do |format|
      if @site.save
        set_updater
        if params[:site]["initial_zone"]
          @site.zones.create(name: params[:site]["initial_zone"], updated_by_id: current_user.id)
        end
        if params[:reports_attributes]
          params[:reports_attributes].each do |report|
            @site.reports.create(image: report[:report_path])
          end
        end
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      @active_panel = params["active_panel"]
      if params.has_key?("props")
        @site.update_properties(params["props"]) 
      end
      if @site.update(site_params)
        set_updater
        add_or_update_zones(params["zone"])
        format.html { redirect_to edit_site_path(@site, active_panel: @active_panel), notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def add_or_update_zones(zone_params)
    return if zone_params.nil?
    zone_params.each do |key,val|
      if key.include?("new_name")
        zone = @site.zones.create(name: val)
      else
        zone = @site.zones.find_by_id(key.gsub("name_",""))
        zone.name = val if val.present?
      end
      zone.updated_by_id = current_user.id
      zone.save!
    end
  end
  
  def site_data
    render json: @site.spreadsheet_data
  end
  
  # POST /sites/1/upload
  def upload
    respond_to do |format|
      if params[:site][:reports_attributes]
        @site.reports.create(report_path: params[:site][:reports_attributes][:report_path])
        format.html { redirect_to edit_site_path(@site, active_panel: @active_panel), notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end
    
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end
    
    def set_updater
      @site.update_column(:updated_by_id, current_user.nil? ? 0 : current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      #(:company_id, :name, :address1, :address2, :city, :state, :zip, :phone, :gps)
      #allowed = params.keys.select{|l| }
      params.require(:site).permit(:company_id, :name, :address1, :address2, :city, :state, :zip, :phone, :gps, :reports_attributes)
    end
end
