class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.text :description
      t.string :holder_model
      t.string :category
      t.integer :holder_id
      t.integer :created_by_id
      t.datetime :created_at

      t.timestamps null: false
    end
  end
end
