class AddHostProfileToMachineTable < ActiveRecord::Migration
  def change
    add_column :machines, :host_profile, :string
  end
end
