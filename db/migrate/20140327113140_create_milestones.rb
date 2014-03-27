class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.string :title
      t.string :image
      t.string :en
      t.string :no
      t.string :sv

      t.timestamps
    end
  end
end
