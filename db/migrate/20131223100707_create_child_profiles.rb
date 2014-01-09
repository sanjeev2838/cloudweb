class CreateChildProfiles < ActiveRecord::Migration
  def change
    create_table :child_profiles do |t|
      t.string :name
      t.string :dob
      t.string :gender
      t.string :status
      t.references :parent_profile, index: true

      t.timestamps
    end
  end
end
