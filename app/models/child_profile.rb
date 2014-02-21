class ChildProfile < ActiveRecord::Base
  attr_accessible :name,:dob,:gender,:status,:preference_id, :child_brewing_preference_attributes

  has_one :child_brewing_preference
  has_many :pictures
  has_many :child_stats
  belongs_to :parent_profile
  #has_many :child_parent_relationships
  #has_many :parent_profiles,:through => :child_parent_relationships
  has_many :parent_profiles

  accepts_nested_attributes_for :child_brewing_preference
  #accepts_nested_attributes_for :pictures
  has_many :logbooks
  has_many :diaries
end
