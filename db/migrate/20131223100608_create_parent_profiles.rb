class CreateParentProfiles < ActiveRecord::Migration
  def change
    create_table :parent_profiles do |t|

      t.integer :devicetypeid
      t.boolean :is_machine_owner
      t.string  :name
      t.boolean :status
      t.string :tokenid
      t.string :email
      t.string :password
      t.string :authtoken

      t.integer :relation
      t.references :machine, index: true

      t.timestamps
    end
  end
end
