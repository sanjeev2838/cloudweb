class Firmware < ActiveRecord::Base
  attr_accessible :binaryfile, :firmwareversion, :serialids,:status

  validates :binaryfile, :firmwareversion, :serialids , :presence => true


  #def self.save(upload)
  #  name =  upload['datafile'].original_filename
  #  directory = "public/firmware"
  #  # create the file path
  #  path = File.join(directory, name)
  #  # write the file
  #  File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  #end
end
