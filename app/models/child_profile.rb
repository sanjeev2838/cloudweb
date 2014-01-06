class ChildProfile < ActiveRecord::Base
  attr_accessible :child_name, :child_brewing_preference_attributes ,:pictures_attributes

  belongs_to :parent_profile
  has_one :child_brewing_preference
  has_many :pictures

  accepts_nested_attributes_for :child_brewing_preference
  accepts_nested_attributes_for :pictures
end
