class CreateMachines < ActiveRecord::Migration

  #  we have written different names as strange way because of our teamlead
  def change
    create_table :machines do |t|
      t.integer :serialid
      t.string :firmware
      t.string :hwconfig
      t.string :macaddress
      t.string :ipaddress
      t.string :bootloader

      t.boolean :status
      t.datetime :activated_on
    end
  end
end
