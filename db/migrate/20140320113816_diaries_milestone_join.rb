class DiariesMilestoneJoin < ActiveRecord::Migration
  def up
    create_table :diaries_milestones, :id => false  do |t|
      t.integer :diary_id
      t.integer :milestone_id
    end
  end

  def down
    drop_table  :diaries_milestones
  end
end
