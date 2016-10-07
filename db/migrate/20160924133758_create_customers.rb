class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
