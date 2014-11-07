class AddProfileRankParentProfile < ActiveRecord::Migration
  def change
    add_column :parent_profiles, :profile_rank, :integer
  end
end
