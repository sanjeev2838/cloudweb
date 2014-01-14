class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :filepath
      t.boolean :status
      t.string :image
      t.boolean :profilepic

      t.references :parent_profile
      t.references :child_profile

      t.timestamps
    end
  end
end
