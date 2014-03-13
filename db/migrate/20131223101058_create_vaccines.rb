class CreateVaccines < ActiveRecord::Migration
  def up
    create_table :vaccines do |t|
      t.string :age
      t.string :year_courses
      t.string :vaccination_against
      t.string :title
      t.string :number_of_doses
      t.string :locale
      t.boolean :status

      t.timestamps
    end

  end
  def down
    drop_table :vaccines

  end
end
