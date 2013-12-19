class AddNameAndServingToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :name, :string
    add_column :recipes, :serving, :integer
  end
end
