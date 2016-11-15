json.extract! site, :id, :company_id, :address1, :address2, :city, :state, :zip, :phone, :gps, :created_at, :updated_at
json.company site.company  
json.url site_url(site, format: :json)