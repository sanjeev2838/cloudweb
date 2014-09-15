class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :volume
      t.integer :key_32
      t.integer :key_33
      t.integer :key_34
      t.integer :key_35
      t.integer :key_36
      t.integer :key_37
      t.integer :key_38
      t.integer :key_39
      t.integer :key_40
      t.integer :key_41
      t.integer :key_42
      t.integer :key_43
      t.integer :key_44
      t.integer :key_45
      t.integer :key_46
      t.integer :key_47
      t.integer :key_48
      t.integer :key_49
      t.integer :key_50

      t.references :product

      t.timestamps
    end
  end
end
