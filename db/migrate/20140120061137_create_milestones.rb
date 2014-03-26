class CreateMilestones < ActiveRecord::Migration
  def up
    create_table :milestones do |t|
      t.string :title
      t.string :image
      t.string :en
      t.string :no
      t.string :sv

      t.timestamps
    end

  end

  def down
    drop_table :vaccines

  end

end
