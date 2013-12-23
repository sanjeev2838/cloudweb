class ParentProfile < ActiveRecord::Base
  attr_accessible :device_id, :device_type_id, :imei, :token_id

  belongs_to :machine
  has_many :child_profiles
end
