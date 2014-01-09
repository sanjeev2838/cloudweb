class CreateLogbooks < ActiveRecord::Migration
  def change
# :log => log_description
    create_table :logbooks do |t|
      t.string :log

      t.references :child_profile
      t.references :parent_profile
      t.timestamps
    end
  end
end
