class ChildBrewingPreference < ActiveRecord::Base
  attr_accessible :milk_qty, :temperature
  belongs_to :child_profile
end
