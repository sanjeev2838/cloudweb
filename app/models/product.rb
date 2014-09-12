class Product < ActiveRecord::Base
  attr_accessible :name
  belongs_to :vendor

  has_many :child_brewing_preferences

end
