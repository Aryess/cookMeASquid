class ChangeFormatInRecipe < ActiveRecord::Migration
  def up
  	change_column :recipes, :difficulty, :integer
  end

  def down
  	change_column :recipes, :difficulty, :string
  end
end
