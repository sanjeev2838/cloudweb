class Vendor < ActiveRecord::Base
  attr_accessible :name, :brew_type
  has_many :products, :dependent => :destroy
  BREW_TYPE = ["Babyformula", "Gruel", "Porridge"]
end
