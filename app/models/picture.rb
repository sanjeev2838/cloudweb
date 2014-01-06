class Picture < ActiveRecord::Base
  attr_accessible :filepath , :image

  belongs_to :child_profile
  #belongs_to :parent_profile

  mount_uploader :image, ImageUploader

end
