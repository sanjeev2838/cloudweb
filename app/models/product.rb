class Product < ActiveRecord::Base
  attr_accessible :name
  belongs_to :vendor

  BREW_TYPE = ["Babyformula", "Gruel", "Porridge"]

  has_many :child_brewing_preferences, dependent: :destroy
  validates :name, presence: true

end
