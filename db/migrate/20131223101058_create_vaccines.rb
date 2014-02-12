class CreateVaccines < ActiveRecord::Migration
  def up
    create_table :vaccines do |t|
      t.string :age
      t.string :year_courses
      t.string :vaccination_against
      t.string :title
      t.string :number_of_doses
      t.boolean :status

      t.timestamps
    end
    Vaccine.create_translation_table! :title => :string,:age=>:string,:year_courses=>:string,:vaccination_against=>:string,:number_of_doses=>:string
  end
  def down
    drop_table :vaccines
    drop_table Vaccine.drop_translation_table!
  end
end
