class CreateVaccineAges < ActiveRecord::Migration
  def change
    create_table :vaccine_ages do |t|
      t.integer :age

      t.references :vaccine
      t.timestamps
    end
  end
end
