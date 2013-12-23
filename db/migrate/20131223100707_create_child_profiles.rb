class CreateChildProfiles < ActiveRecord::Migration
  def change
    create_table :child_profiles do |t|
      t.string :child_name
      t.references :parent_profile, index: true

      t.timestamps
    end
  end
end
