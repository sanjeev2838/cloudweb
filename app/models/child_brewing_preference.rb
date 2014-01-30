class ChildBrewingPreference < ActiveRecord::Base
  attr_accessible :milk, :temperature
  validates :milk, :temperature, :presence => true

  belongs_to :child_profile,:dependent => :destroy, :foreign_key  => :child_profile_id
end
