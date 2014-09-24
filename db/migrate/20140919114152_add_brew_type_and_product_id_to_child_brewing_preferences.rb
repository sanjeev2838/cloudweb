class AddBrewTypeAndProductIdToChildBrewingPreferences < ActiveRecord::Migration
  def change
    add_column :child_brewing_preferences, :brew_type, :string
    add_column :child_brewing_preferences, :product_id, :integer
  end
end
