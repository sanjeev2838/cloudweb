class CreateFirmwares < ActiveRecord::Migration
  def change
    create_table :firmwares do |t|
      t.string :firmwareversion
      t.string :serialids
      t.string :binaryfile
      t.boolean :status

      t.timestamps
    end
  end
end
