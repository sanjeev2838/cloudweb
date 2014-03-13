class CreateVaccineLanguages < ActiveRecord::Migration
  def change
    create_table :vaccine_languages do |t|
      t.string :title
      t.string :locale

      t.references :vaccine
      t.timestamps
    end
  end
end
