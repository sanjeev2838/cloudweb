class CreateMilestones < ActiveRecord::Migration
  def up
    create_table :milestones do |t|
      t.string :title
      t.string :lang
      t.string :image

      t.timestamps
    end
    Milestone.create_translation_table! :title => :string
  end

  def down
    drop_table :vaccines
    drop_table Milestone.drop_translation_table!
  end

end
