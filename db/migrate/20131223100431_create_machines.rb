class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.integer :serial_number
      t.boolean :status
      t.datetime :activated_on
      t.string :firmware_version
      t.string :hw_config
      t.string :mac_address
      t.string :ip_address

      t.references :user

      t.timestamps
    end
  end
end
