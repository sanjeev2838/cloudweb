class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :filepath

      t.references :child_profile

      t.timestamps
    end
  end
end
