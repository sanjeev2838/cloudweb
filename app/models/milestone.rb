class Milestone < ActiveRecord::Base
  attr_accessible :title

  #has_many :languages

  translates :title
end
