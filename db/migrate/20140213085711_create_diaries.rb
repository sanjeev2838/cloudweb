class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.string :log

      t.references :milestone
      t.references :child_profile
      t.timestamps
    end
  end
end
