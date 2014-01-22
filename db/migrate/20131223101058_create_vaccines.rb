class CreateVaccines < ActiveRecord::Migration
  def up
    create_table :vaccines do |t|
      t.string :title

      t.timestamps
    end
    Vaccine.create_translation_table! :title => :string
  end
  def down
    drop_table :vaccines
    drop_table Vaccine.drop_translation_table!
  end
end
