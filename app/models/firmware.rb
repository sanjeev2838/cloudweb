class Firmware < ActiveRecord::Base
  attr_accessible :binaryfile, :firmwareversion, :serialids,:status

  validates :binaryfile, :firmwareversion, :serialids , :presence => true



end
