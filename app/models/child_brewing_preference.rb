class ChildBrewingPreference < ActiveRecord::Base
  attr_accessible :milk_qty, :temperature
  belongs_to :child_profile
  belongs_to :parent_profile
end
