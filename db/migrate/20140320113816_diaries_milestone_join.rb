class DiariesMilestoneJoin < ActiveRecord::Migration
  def up
    create_table :diaries_milestone_join, :id => false  do |t|
      t.integer :diary_id
      t.integer :milestone_id
    end
  end

end
