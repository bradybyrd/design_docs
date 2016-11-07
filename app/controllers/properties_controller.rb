class PropertiesController < ApplicationController
  before_filter :authenticate_user!
  
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  # GET /properties
  # GET /properties.json
  def index
    @form_increment = 1
    @add_action = 'index'
    @properties = Property.unarchived.ordered
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)
    @property.created_by_id = current_user.id unless current_user.nil?
    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to properties_path, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET Ajax form get
  def add_new_property
    inc = params["form_increment"] || 0
    @form_increment = inc.to_i + 1
    @add_action = params["add_action"]
    if @add_action != "index"
      val = params["associated_model"]
      associated_model = val.split("__")[0].camelize
      associated_model_id = val.split("__")[1]
      @property_list = Property.for_model(associated_model).unarchived.ordered unless associated_model
    end
    render('_add_new_property_table', layout: false)
  end

  # POST
  def create_new_properties
    props = params["props"]
    (1..50).each do |inc|
      if props.has_key?("new_name_#{inc}") && props["new_name_#{inc}"].length > 1
        prop = Property.find_or_create_by(name: props["new_name_#{inc}"], holder_model: props["select_holder_model_#{inc}"])
        attrs = {
          category: props["new_category_#{inc}"],
          position: props["new_position_#{inc}"],
          tip: props["new_tip_#{inc}"],
          updated_by_id: current_user.id
        }
        prop.update_attributes attrs
        logger.info "Adding Property: #{prop.inspect}"
      else
        break
      end
    end
    redirect_to properties_path
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:name, :description, :category, :holder_model, :tip, :position, :updated_by_id, :created_at, :associated_model, :form_increment)
    end
end
