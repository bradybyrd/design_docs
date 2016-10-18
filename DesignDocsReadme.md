# DesignDocs - Treatment App

* Devise Setup *
Some setup you must do manually if you haven't yet:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

  4. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

### SimpleForm
Inside your views, use the 'simple_form_for' with one of the Bootstrap form
  classes, '.form-horizontal' or '.form-inline', as the following:

    = simple_form_for(@user, html: { class: 'form-horizontal' }) do |form|
		
## Adding Models:
	rails g scaffold Customer name:string
	
	rails g model Discussion user_id:integer:index body:text holder_model:string holder_id:integer parent_id:integer
	
	rails g scaffold Customer name:string, description:text
	
	rails g scaffold Site customer_id:integer address1:string address2:string city:string state:string zip:string phone:string gps:string
	
	rails g scaffold Property name:string, description:text holder_model:string holder_id:integer created_by_id:integer created_at:datetime
	
	rails g model PropertyValue property_id:integer data:string archived_at:datetime archived_by_id:integer
	
TreatmentDesign
Customer
	id
	name
User
	blah blah


Basin
	site_id
	Depth
	DiffuserDepth
	Width
	Length
	Diameter
	SurfaceArea (calc)
	SideSlopeRatio
	Volume (calc)
Influent
	site_id
	Design Flow	
	BODConcentration                    a) concentration	
	BODInflowRate                                             b) weight/d	
	BODRemovalPercent				Primary Treatment (% BOD Removal)	
	% BOD Remaining (calc- 100% - Primary Treatment)	
	Design BOD removal	
	Carbonaceous BOD(5) to the aeration basin 	(calc- BOD Raw Waste) x (% BOD Remaining)	          	
	Mixed Liquor Suspended Solids, MLSS	
	Aeration Detention Time, HRT	
	f/m ratio	
	Specific Loading Rate, lb BOD5 / kcf / day	
	Oxygen per unit of carbonaceous BOD removed	
	Oxygen requirements for Carbonaceous BOD	
	Ammonia to aeration basin concentration	
	Ammonia to aeration basin weight/d                    
	Oxygen requirements for Ammonia		(calc- Ammonia to aeration basin) x (4.57#O2/#NH3-N)
	Total oxygen requirements, AOR		(calc- Oxygen requirement for BOD and Ammonia)	          
ConstantSet
	id
	name
	description
	creator_id
ConstantValue
	constant_set_id
	constant_id
	assigned_value
Constant
	id
	component_id
	name
	default_value
	description
Site
	id
	name
	customer_id
	constant_set_id
	elevation
	description
	gps
	phone
	Operating ambient pressure, winter
	Operating ambient pressure, summer
	Dissolved O2 level in the aeration basin (default is 2.0)
	Basin Winter Temperature
	Basin Summer Temperature
	Winter surface saturation, Csmt
	Summer surface saturation, Csmt
	Effective depth correction factor
	Standard condition aerated O2 saturation in the tank (calc- C*20=9.09*(29.92+0.8828*Depth Correction*Depth)/29.92)
	Theta value (calc- AOR/SOR=ALPHA[BETA(C*20)(Csmt/9.09)(Psite/Psc)- DO](THETA)^(Temp-20)/(C*20), Winter    AOR/SOR, Summer AOR/SOR)
	Standard Oxygen Transfer Rate (per day)
	Aeration Time
	Standard Oxygen Transfer Rate (per hour)
	SOR/diffuser

SiteComponents
	site_id
	component_id
	
Component
	id
	name
	description

Item Level Authorization
	Role => Privs
		Privs - Role_id, model, action
	authorize!('basins','edit')
		current_user.has_privilege(model_class, action)


Preferences
	DateTime format
	Company Name
	Color Theme
		