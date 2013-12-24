class ParentProfile < ActiveRecord::Base
  attr_accessible :device_id, :device_type_id, :imei, :token_id

  #belongs_to :machine
  has_many :child_profiles
  has_many :pictures
  has_many :child_stats
  has_many :child_brewing_preferences
end
