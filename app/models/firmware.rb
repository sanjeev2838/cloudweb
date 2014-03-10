class Firmware < ActiveRecord::Base
  attr_accessible :binaryfile, :firmwareversion, :serialids,:status

  validates :binaryfile, :firmwareversion, :serialids , :presence => true

  serial_id_regex = /[1-9]\d*(,\d+)?$/
  validates :serialids ,format:     { with: serial_id_regex }


end
