class Picture < ActiveRecord::Base
  attr_accessible :filepath , :image, :profilepic,:child_profile_id

  belongs_to :child_profile
  #belongs_to :parent_profile
  belongs_to :diary
  belongs_to :milestone

  mount_uploader :image, ImageUploader


  #after_create :set_file_path
  #private
  #def set_file_path
  #  self.filepath= "uploads/#{self.class.to_s.underscore}/#{mounted_as}/#{self.id}/#{image}"
  #  save!
  #end
end
