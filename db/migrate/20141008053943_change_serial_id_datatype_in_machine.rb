class ChangeSerialIdDatatypeInMachine < ActiveRecord::Migration
  def up
    change_column :machines, :serialid, :string
  end

  def down
    change_column :machines, :serialid, :integer
  end
end
