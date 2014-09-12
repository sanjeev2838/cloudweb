class ChildBrewingPreference < ActiveRecord::Base
  attr_accessible :milk, :temperature, :water, :quantity, :brew_type, :product_id
  validates :milk, :temperature, :presence => true

  belongs_to :child_profile,:dependent => :destroy
  belongs_to :product
end
