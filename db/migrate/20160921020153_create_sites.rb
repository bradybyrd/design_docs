class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.integer :customer_id
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :gps
      t.integer :updated_by_id
      t.timestamps null: false
    end
  end
end
