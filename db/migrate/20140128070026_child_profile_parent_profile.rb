class ChildProfileParentProfile < ActiveRecord::Migration
  def up
    create_table :child_profiles_parent_profiles do |t|
      t.references :child_profile
      t.references :parent_profile
    end

  end

  def down
  end
end
