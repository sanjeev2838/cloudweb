class CreateChildBrewingPreferences < ActiveRecord::Migration
  def change
    create_table :child_brewing_preferences do |t|
      t.integer :temperature
      t.integer :milk

      t.references :child_profile
      t.references :parent_profile

      t.timestamps
    end
  end
end
