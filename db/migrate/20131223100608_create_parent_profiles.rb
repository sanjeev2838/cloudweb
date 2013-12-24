class CreateParentProfiles < ActiveRecord::Migration
  def change
    create_table :parent_profiles do |t|
      t.integer :device_id
      t.integer :device_type_id
      t.boolean :is_machine_owner
      t.string  :name
      t.boolean :status
      t.string :imei
      t.string :token_id
      t.references :machine, index: true

      t.timestamps
    end
  end
end
