class ChildProfile < ActiveRecord::Base
  attr_accessible :child_name

  belongs_to :parent_profile
  has_many :child_stats
  has_many :child_brewing_preferences
  has_many :pictures
end
