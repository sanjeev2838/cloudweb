class Milestone < ActiveRecord::Base
  attr_accessible :title

  #has_many :languages
  has_one :picture

  translates :title
end
