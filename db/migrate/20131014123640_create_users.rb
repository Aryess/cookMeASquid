class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.integer :age
      t.string :email
      t.string :login

      t.timestamps
    end
  end
end
