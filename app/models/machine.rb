class Machine < ActiveRecord::Base
  attr_accessible :activated_on, :firmware, :hwconfig, :ipaddress, :macaddress, :serialid, :status,
                  :bootloader
  validates :firmware, :hwconfig, :bootloader, :presence => true
  validates :serialid,:presence => true, :uniqueness => true
  #has_many :parent_profiles
  @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  @mac_address = /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
  validates :ipaddress,
            :presence => true,
            :format => { :with => @ip_regex }
  validates :macaddress,
            :presence => true,
            :uniqueness => true,
            :format => { :with => @mac_address }
  has_many :machine_logs
  has_many :parent_profiles

  before_save :set_activated_on

  def self.save(upload)
    name =  upload['datafile'].original_filename
    directory = "public/firmware"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end

  protected

  def set_activated_on
    self.activated_on = Time.now
  end
end
