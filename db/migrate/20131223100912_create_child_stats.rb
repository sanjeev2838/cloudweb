class CreateChildStats < ActiveRecord::Migration
  def change
    create_table :child_stats do |t|
      t.integer :diaper_count
      t.integer :weight
      t.integer :height
      t.string :food

      t.references :parent_profile
      t.references :child_profile, index: true
      t.references :vaccine

      t.timestamps
    end
  end
end
