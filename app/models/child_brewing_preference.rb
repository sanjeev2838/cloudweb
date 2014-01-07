class ChildBrewingPreference < ActiveRecord::Base
  attr_accessible :milk, :temperature
  belongs_to :child_profile
end
