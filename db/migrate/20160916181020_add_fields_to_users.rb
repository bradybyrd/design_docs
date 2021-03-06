class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer
    add_column :users, :first_name, :string
    add_column :users, :company_id, :integer
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :timezone, :string
    add_column :users, :comments, :text 
  end
end
