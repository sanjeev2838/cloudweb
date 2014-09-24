class Product < ActiveRecord::Base
  attr_accessible :name, :brew_type, :vendor_id
  belongs_to :vendor
  has_many :profiles

  BREW_TYPE = ["Babyformula", "Gruel", "Porridge"]

  validates :name, presence: true
end
