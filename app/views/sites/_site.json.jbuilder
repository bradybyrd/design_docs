json.extract! site, :id, :customer_id, :address1, :address2, :city, :state, :zip, :phone, :gps, :created_at, :updated_at
json.url site_url(site, format: :json)