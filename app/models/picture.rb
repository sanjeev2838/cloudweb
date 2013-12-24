class Picture < ActiveRecord::Base
  attr_accessible :filepath

  belongs_to :child_profile
  belongs_to :parent_profile
end
