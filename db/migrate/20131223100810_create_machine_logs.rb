class CreateMachineLogs < ActiveRecord::Migration
  def change
    create_table :machine_logs do |t|
      t.string :data
      t.references :machine, index: true

      t.timestamps
    end
  end
end
