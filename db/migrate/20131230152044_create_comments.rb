class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :rating
      t.integer :recipe_id
      t.integer :user_id

      t.timestamps
    end

    add_index :comments, :recipe_id
    add_index :comments, :user_id
    add_index :comments, [:recipe_id, :user_id], unique: true
  end
end
