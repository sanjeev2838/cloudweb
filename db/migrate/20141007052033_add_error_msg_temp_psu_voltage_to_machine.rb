class AddErrorMsgTempPsuVoltageToMachine < ActiveRecord::Migration
  def change
    add_column :machines, :error_msg, :string
    add_column :machines, :temp, :string
    add_column :machines, :psu_voltage, :string
  end
end
