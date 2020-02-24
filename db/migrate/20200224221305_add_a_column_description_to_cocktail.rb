class AddAColumnDescriptionToCocktail < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :description_drink, :text
  end
end
