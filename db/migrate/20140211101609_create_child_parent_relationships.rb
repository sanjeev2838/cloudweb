class CreateChildParentRelationships < ActiveRecord::Migration
  def change
    create_table :child_parent_relationships do |t|
      t.references :child_profile
      t.references :parent_profile

      t.timestamps
    end
  end
end
