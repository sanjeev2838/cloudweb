class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.string :title
      t.string :icon

      t.references :language
      t.timestamps
    end
  end
end
