class AddWaterBrewtypeQuantityToChildBrewingPreferences < ActiveRecord::Migration
  def change
    add_column :child_brewing_preferences, :water, :float
    add_column :child_brewing_preferences, :quantity, :float
    add_column :child_brewing_preferences, :brew_type, :string
    add_column :child_brewing_preferences, :product_id, :integer
  end
end
