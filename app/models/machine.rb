class Machine < ActiveRecord::Base
  attr_accessible :activated_on, :firmware_version, :hw_config, :ip_address, :mac_address, :serial_number, :status

  belongs_to :user
  has_many :parent_profiles
  has_many :machine_logs
end
