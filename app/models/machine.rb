class Machine < ActiveRecord::Base
  attr_accessible :activated_on, :firmware_version, :hw_config, :ip_address, :mac_address, :serial_number, :status,
                  :bootloader_version
  validates :activated_on, :firmware_version, :hw_config, :serial_number,
            :bootloader_version, :presence => true , :uniqueness => true
  #has_many :parent_profiles
  @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  @mac_address = /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
  validates :ip_address,
            :presence => true,
            :uniqueness => true,
            :format => { :with => @ip_regex }
  validates :mac_address,
            :presence => true,
            :uniqueness => true,
            :format => { :with => @mac_address }
  has_many :machine_logs
  has_many :parent_profiles
end
