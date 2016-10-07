class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.integer :user_id
      t.text :body
      t.string :holder_model
      t.integer :holder_id
      t.integer :parent_id

      t.timestamps null: false
    end
    add_index :discussions, :user_id
  end
end
