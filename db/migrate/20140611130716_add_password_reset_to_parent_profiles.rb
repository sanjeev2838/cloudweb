class AddPasswordResetToParentProfiles < ActiveRecord::Migration
  def change
    add_column :parent_profiles, :password_reset_token, :string
    add_column :parent_profiles, :password_reset_sent_at, :datetime
  end
end
