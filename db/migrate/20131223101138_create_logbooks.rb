class CreateLogbooks < ActiveRecord::Migration
  def change
    create_table :logbooks do |t|
      t.string :description

      t.references :child_profile
      t.references :user
      t.references :parent_profile
      t.timestamps
    end
  end
end
