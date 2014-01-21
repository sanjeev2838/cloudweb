class Vaccine < ActiveRecord::Base
  attr_accessible :title

  belongs_to :child_stat

  translates :title

end
