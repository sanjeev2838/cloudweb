class AddStatusToChildProfile < ActiveRecord::Migration
  def change
    add_column :child_profiles, :status, :boolean
  end
end
