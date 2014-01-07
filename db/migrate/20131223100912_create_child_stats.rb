class CreateChildStats < ActiveRecord::Migration
  def change
    create_table :child_stats do |t|
      t.integer :diaper_count
      t.integer :weight
      t.integer :height
      t.string :meals
      t.integer :bottle

      t.references :parent_profile
      t.references :child_profile, index: true
      t.references :vaccine

      t.timestamps
    end
  end
end
