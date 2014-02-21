class CreateMachineLogs < ActiveRecord::Migration
  def change
    create_table :machine_logs do |t|
      t.integer :data
      t.references :machine, index: true

      t.timestamps
    end
  end
end
