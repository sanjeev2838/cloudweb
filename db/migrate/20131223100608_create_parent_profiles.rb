class CreateParentProfiles < ActiveRecord::Migration
  def change
    create_table :parent_profiles do |t|
      t.integer :deviceid
      t.integer :devicetypeid
      t.boolean :is_machine_owner
      t.string  :name
      t.boolean :status
      t.string :imei
      t.string :tokenid
      t.references :machine, index: true

      t.timestamps
    end
  end
end
