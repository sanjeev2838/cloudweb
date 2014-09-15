class Product < ActiveRecord::Base
  attr_accessible :name, :brew_type, :vendor_id
  belongs_to :vendor

  BREW_TYPE = ["Babyformula", "Gruel", "Porridge"]

  # has_many :child_brewing_preferences, dependent: :destroy
  validates :name, presence: true

end
